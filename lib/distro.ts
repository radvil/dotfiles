import { colors } from "@cliffy/ansi/colors";
import { log } from "./log.ts";
import { DistroId, PackagerByDistro } from "../constants/distro.ts";

export function getAvailableDistros() {
  return Object.keys(PackagerByDistro) as DistroId[];
}

export async function detectDistro(): Promise<DistroId> {
  try {
    const osRelease = await Deno.readTextFile("/etc/os-release");
    const idMatch = osRelease.match(/^ID="?([a-zA-Z0-9]+)"?/m);

    const selected = idMatch?.[1].toLowerCase();
    if (!selected) {
      Deno.exit(1);
    }

    const matched = getAvailableDistros().some((v) => v === selected);
    if (!matched) {
      throw new Error(`"${colors.yellow(selected)}" is not supported!`);
    }

    return selected as DistroId;
  } catch (err) {
    log.error(`Failed to read /etc/os-release: ${err}`);
    Deno.exit(1);
  }
}
