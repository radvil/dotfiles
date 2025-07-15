import { colors } from "@cliffy/ansi/colors";
import { log } from "../lib/log.ts";
import { resolveManifest } from "../lib/manifest.ts";
import z from "zod/v4";

const schemaActionDebug = z.object({ id: z.string() });

type Flags = z.infer<typeof schemaActionDebug>;

const actionDebugComponent = async (rawFlags: unknown, cmpName: string) => {
  const flags: Flags = schemaActionDebug.parse(rawFlags);
  log.info("ID:", flags.id);

  const manifest = await resolveManifest(cmpName);
  log.info("MANIFEST:");

  console.log(colors.yellow(JSON.stringify(manifest, null, 2)));
};

export const ActionDebug = {
  Schema: schemaActionDebug,
  Runner: actionDebugComponent,
};
