import { resolveManifest } from "./lib/manifest.ts";
import { getComponentBuilds } from "./actions/install.ts";

export const TestFunc = async (_rawFlags: unknown, ..._args: unknown[]) => {
  const manifest = await resolveManifest("tmux");
  const commands = await getComponentBuilds("nobara", manifest);
  console.log(commands);
};
