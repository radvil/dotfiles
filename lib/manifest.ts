import { z } from "zod/v4";
import { colors as c } from "@cliffy/ansi/colors";
import { Table } from "@cliffy/table";
import { join } from "@std/path/join";
import { exists } from "@std/fs/exists";
import { parse } from "@std/jsonc/parse";
import { log } from "./log.ts";
import { detectDistro, getAvailableDistros } from "./distro.ts";

// TODO: set env variables for this!
const basePath = "./components";
const availableTags = [...getAvailableDistros(), "*"];

/**
 * Describes a config file/folder source on each component.
 * e.g., src/LazyVim src/assets src/.tmux
 */
export const ConfigSrcSchema = z.object({
  /**
   * Source path, relative to the component's root directory.
   */
  from: z.string(),

  /**
   * Destination path on the host system (e.g., ~/.config/nvim).
   * May contain ~ for home directory and will be resolved at runtime.
   */
  to: z.string(),

  /**
   * Installation method: copy the file or create a symlink.
   */
  method: z.enum(["copy", "symlink"]),

  /**
   * If true, allow overwriting/removing the destination path before applying.
   * Defaults to false (will error if destination already exists).
   */
  force: z.coerce.boolean().default(false),

  /**
   * Config tags associated with component's id
   * Defaults to `all`
   */
  tags: z.array(z.enum(availableTags)),
});

export type ConfigSrc = z.infer<typeof ConfigSrcSchema>;

export const DotfileManifestSchema = z.object({
  name: z.string(),
  description: z.string().optional(),
  priority: z.coerce.number().optional(),
  builds: z
    .partialRecord(z.enum(availableTags), z.array(z.string()))
    .optional(),
  configs: z.array(ConfigSrcSchema).optional(),
  cleanup: z.array(z.string()).optional(),
});

export type DotfileManifest = z.infer<typeof DotfileManifestSchema>;

/**
 * Load and validate a component manifest:
 * - manifest.jsonc must exist
 * - src/ must exist
 * - files[].from must resolve to existing files/dirs under src/
 */
export async function resolveManifest(
  cmpName: string,
): Promise<DotfileManifest> {
  const folder = cmpName.toLowerCase();
  const basePath = join("components", folder);
  const manifestPath = join(basePath, "manifest.jsonc");
  const srcPath = join(basePath, "src");

  try {
    const raw = await Deno.readTextFile(manifestPath);
    const parsed = parse(raw);
    const manifest = DotfileManifestSchema.parse(parsed);

    // Check that src/ exists
    const srcStat = await Deno.stat(srcPath).catch(() => null);
    if (!srcStat?.isDirectory) {
      throw new Error(`Missing or invalid src/ folder: ${srcPath}`);
    }

    // Validate files[].from
    if (manifest.configs) {
      for (const file of manifest.configs) {
        const fullFromPath = join(basePath, file.from);
        const stat = await Deno.stat(fullFromPath).catch(() => null);
        if (!stat) {
          throw new Error(
            `File not found: ${fullFromPath} (from: ${file.from})`,
          );
        }
      }
    }

    return manifest;
  } catch (err) {
    if (err instanceof Error) {
      throw new Error(`Something went wrong: ${err.message}`);
    }
    throw new Error("Unknown error occurred");
  }
}

const ManifestSummarySchema = z.object({
  name: z.string(),
  description: z.string().optional(),
  priority: z.number().optional(), // ← New
});

export type ManifestSummary = z.infer<typeof ManifestSummarySchema>;

async function getManifest(entryName: string) {
  const manifestPath = join(basePath, entryName, "manifest.jsonc");
  const found = await exists(manifestPath);
  if (!found) {
    log.warn(c.green(entryName), `has no manifest.jsonc`);
  }

  try {
    const content = await Deno.readTextFile(manifestPath);
    const parsed = parse(content);
    const manifest = DotfileManifestSchema.parse(parsed);
    return manifest;
  } catch (e) {
    const msg = e instanceof Error ? e.message : JSON.stringify(e);
    log.error(c.green(entryName), msg);
  }
}

// TODO: should support filter by names here,
// If empty then retrive all under `components/`
export async function getAvailableManifests(
  sortBy: "priority" | "name",
  cmpNames: string[] = [],
): Promise<DotfileManifest[]> {
  const manifests: DotfileManifest[] = [];

  if (cmpNames.length) {
    for await (const cmpName of cmpNames) {
      const manifest = await getManifest(cmpName);
      manifest && manifests.push(manifest);
    }
  } else {
    for await (const entry of Deno.readDir(basePath)) {
      if (!entry.isDirectory) continue;
      const manifest = await getManifest(entry.name);
      manifest && manifests.push(manifest);
    }
  }

  if (sortBy === "priority") {
    manifests.sort((a, b) => {
      const ap = a.priority ?? Infinity;
      const bp = b.priority ?? Infinity;
      return ap !== bp ? ap - bp : a.name.localeCompare(b.name);
    });
  } else {
    manifests.sort((a, b) => a.name.localeCompare(b.name));
  }

  return manifests;
}

// TODO: supports specific columns only
export async function printComponentsSummaries(
  entries: DotfileManifest[],
  printType: "json" | "table",
) {
  if (printType === "json") {
    console.log(JSON.stringify(entries, null, 2));
    return;
  }

  if (entries.length === 0) {
    log.error("No components with valid manifests found.");
    return;
  }

  if (printType === "table") {
    const machineId = await detectDistro();
    const rows = entries.map((cmp) => {
      const nameColor = (priority: number | undefined) => {
        if (priority === undefined) return c.white;
        if (priority <= 1) return c.brightGreen;
        if (priority <= 4) return c.yellow;
        return c.gray;
      };

      const source = cmp.configs?.map((x) => `${c.yellow(x.from)}`).join("\n");
      const dest = cmp.configs?.map((x) => `${c.green(x.to)}`).join("\n");
      const tags = cmp.configs
        ?.map((x) => `${c.cyan(x.tags.join(", "))}`)
        .join("\n");

      const fallbackPath = c.bgYellow.black.bold(" UNKNOWN/MANUAL ");
      const fallbackTags = `${c.bgCyan.black.bold(" FALLBACK ")} ${
        c.cyan(machineId)
      }`;

      return [
        nameColor(cmp.priority)(cmp.name),
        cmp.priority || "N/A",
        source || fallbackPath,
        dest || fallbackPath,
        tags || fallbackTags,
      ];
    });

    new Table()
      .header(["Component", "Priority", "Source", "Dest", "Tags"])
      .border(true)
      .body(rows)
      .render();

    return;
  }

  for (const comp of entries) {
    let name = comp.name;

    if (typeof comp.priority === "number") {
      if (comp.priority <= 1) name = c.brightGreen(name);
      else if (comp.priority <= 4) name = c.yellow(name);
      else name = c.gray(name);
    }

    const desc = comp.description ? ` — ${comp.description}` : "";
    console.log(name + desc);
  }
}
