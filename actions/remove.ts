import z from "zod/v4";
import { ArgumentValue } from "@cliffy/command";
import { colors as c } from "@cliffy/ansi/colors";
import { log } from "../lib/log.ts";
import { resolveManifest } from "../lib/manifest.ts";
import { runShellCommand } from "../lib/shell.ts";

const schemaActionRemove = z.object({
  dryRun: z.coerce.boolean().default(false),
});

type Flags = z.infer<typeof schemaActionRemove>;

const actionRemoveComponent = async (
  rawFlags: unknown,
  ...args: ArgumentValue["name"][]
) => {
  const flags: Flags = schemaActionRemove.parse(rawFlags);
  const cmpNames = [...args].filter((x) => typeof x === "string");

  for await (const cmpName of cmpNames) {
    const manifest = await resolveManifest(cmpName);
    if (manifest.cleanup?.length) {
      log.info(`Exec cleanup commands for ${c.green(manifest.name)}:`);
      for (const cmd of manifest.cleanup) {
        await runShellCommand(cmd, flags.dryRun);
      }
    }
  }
};

export const ActionRemove = {
  Schema: schemaActionRemove,
  Runner: actionRemoveComponent,
};
