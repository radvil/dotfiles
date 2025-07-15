import $ from "@david/dax";
import { colors as c } from "@cliffy/ansi/colors";
import { log } from "./log.ts";

export async function runShellCommand(cmd: string, dryRun = false) {
  if (dryRun) {
    console.log(c.bgYellow.black(" DRY-RUN "), "⤷", c.yellow(cmd));
    return;
  }

  console.log(c.bgBrightCyan.white(" RUN  "), "⤷", c.cyan(cmd));

  try {
    await $`'${cmd}'`;
  } catch (err) {
    log.error(`Command failed: ${cmd}`);
    if (err instanceof Error) {
      console.error(err.message);
    }
  }
}

function isExecutable(mode: number): boolean {
  const isOwnerExecutable = (mode & 0o100) !== 0;
  const isGroupExecutable = (mode & 0o010) !== 0;
  const isOthersExecutable = (mode & 0o001) !== 0;
  return isOwnerExecutable || isGroupExecutable || isOthersExecutable;
}

/*
 * Example usage:
 * const executable = await ensureExecutable("./mamamia.sh");
 * console.log("Is executable?", executable);
 */
export async function ensureExecutable(path: string): Promise<boolean> {
  try {
    const stat = await Deno.lstat(path);
    const executable = stat.isFile && stat.mode !== null &&
      isExecutable(stat.mode);
    if (!executable) {
      await Deno.chmod(path, 0o755);
    }
    return executable;
  } catch (err) {
    if (err instanceof Deno.errors.NotFound) return false;
    throw err;
  }
}
