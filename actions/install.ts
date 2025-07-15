import z from "zod/v4";
import { colors as c } from "@cliffy/ansi/colors";
import { join } from "@std/path/join";
import { exists } from "@std/fs/exists";
import { ArgumentValue } from "@cliffy/command";
import { log } from "../lib/log.ts";
import {
  ConfigSrcSchema,
  DotfileManifest,
  getAvailableManifests,
  printComponentsSummaries,
} from "../lib/manifest.ts";
import { ensureExecutable, runShellCommand } from "../lib/shell.ts";
import { performFileOperation, resolveHomePath } from "../lib/fs.ts";
import { detectDistro } from "../lib/distro.ts";
import { strListToArray } from "../lib/string.ts";

const schemaActionInstall = z.object({
  tags: z.string().optional().transform(strListToArray),
  sort: z.enum(["priority", "name"]).optional().default("priority"),
  dryRun: z.coerce.boolean().default(false),
  force: z.coerce.boolean().default(false),
  skipBuilds: z.coerce.boolean().default(false),
  skipFiles: z.coerce.boolean().default(false),
});

type Flags = z.infer<typeof schemaActionInstall>;

export async function getComponentBuilds(
  machineId: string,
  man: DotfileManifest,
): Promise<string[]> {
  const commands = man.builds?.[machineId] || man.builds?.["*"] || [];
  const buildsDir = join("./components", man.name, "builds");
  const fullPath = resolveHomePath(buildsDir);

  if (!(await exists(fullPath))) {
    return commands;
  }

  for await (const entry of Deno.readDir(fullPath)) {
    const matched = entry.name.split(".")[0] === machineId;
    if (!entry.isFile || !matched) continue;
    const filePath = `${fullPath}/${entry.name}`;
    await ensureExecutable(filePath);
    commands.push(`bash -c "${filePath}"`);
  }

  return commands;
}

async function installBuilds(id: string, entry: DotfileManifest, flags: Flags) {
  if (flags.skipBuilds) {
    log.skip(`${c.yellow("--skip-builds")} for ${c.green(entry.name)}...`);
    return;
  }

  log.title(`Installing component ${c.green(entry.name)}...`);

  try {
    const commands = await getComponentBuilds(id, entry);
    if (!commands?.length) {
      log.skip(`${c.green(entry.name)} has no build commands.`);
      return;
    }

    for await (const cmd of commands) {
      await runShellCommand(cmd, flags.dryRun);
    }
  } catch (error) {
    const e = error instanceof Error ? error.message : JSON.stringify(error);
    log.error(`Failed to execute builds for ${c.green(entry.name)}`, e);
  }
}

async function installConfigs(id: string, entry: DotfileManifest, f: Flags) {
  try {
    const configs = entry.configs;

    if (f.skipFiles) {
      log.skip(
        `Component: ${c.green(entry.name)}. ${
          c.yellow(
            "--skip-files",
          )
        } specified`,
      );
      return;
    }

    if (!configs?.length) {
      log.skip(`Component: ${entry.name} has no configs provided`);
      return;
    }

    // install configs
    log.info("Configurations:");

    for await (const rawConfig of configs) {
      const config = ConfigSrcSchema.parse(rawConfig);

      // if --tags was not specified use distroId.
      const selectedTags = f.tags ?? [id, "*"];
      const hasTagged = config.tags.some((x) => selectedTags.includes(x));
      if (!hasTagged) continue;

      const icon = config.method === "symlink" ? "🔗" : "📄";
      const method = config.method.toUpperCase();
      const msg = `${icon} ${method}: ${c.yellow(config.from)} → ${
        c.green(
          config.to,
        )
      }`;

      console.log(msg);

      if (f.dryRun) continue;

      await performFileOperation(entry.name, config, f.force);
    }

    log.success(`✔ Config: '${entry.name}' installed!`);
  } catch (err) {
    // make sure to run the run the rest when one produced error.
    const msg = err instanceof Error
      ? `Failed to install config for "${entry.name}". ${err.message}`
      : `An error occured when installing config for "${entry.name}"`;
    log.error(msg);
  }
}

// TODO: support multi components e.g., fish,neovim,tmux
// TODO: display detected distro/id with confirmation if --id=distroName was not specified.
const actionInstallComponents = async (
  rawFlags: unknown,
  ...args: ArgumentValue["name"][]
) => {
  const cmpNames = [...args].filter((x) => typeof x === "string");
  const f: Flags = schemaActionInstall.parse(rawFlags);

  if (f.skipFiles && f.skipBuilds) {
    log.error("Can't use --only-files and --only-builds together.");
    Deno.exit(1);
  }

  const machineId = await detectDistro();
  const autoTags = f.tags ?? [machineId, "*"];
  const all: DotfileManifest[] = await getAvailableManifests(f.sort, cmpNames);
  const filteredByTags: DotfileManifest[] = f.tags?.length
    ? all.filter((x) => {
      return x.configs?.some((v) => {
        return v.tags.some((z) => autoTags.includes(z));
      });
    })
    : all;

  let msg = "Following component(s) will be installed.";
  if (filteredByTags.length) {
    msg += ` Tags: ${c.yellow(autoTags.join(",").replace(",*", ""))}`;
  }

  log.title(msg);
  await printComponentsSummaries(filteredByTags, "table");

  for await (const entry of filteredByTags) {
    await installBuilds(machineId, entry, f);
    await installConfigs(machineId, entry, f);
  }
};

export const ActionInstall = {
  Schema: schemaActionInstall,
  Runner: actionInstallComponents,
};
