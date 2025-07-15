import { resolve } from "@std/path";
import { copy, ensureDir } from "@std/fs";
import { log } from "./log.ts";
import { ConfigSrc } from "./manifest.ts";

/**
 * Expands ~ to $HOME if present in a path like "~/.config/nvim"
 *
 * USAGE:
 * ```typescript
 * const dest = resolveHomePath(file.to);
 * ```
 */
export function resolveHomePath(path: string): string {
  if (path.startsWith("~")) {
    const home = Deno.env.get("HOME");
    if (!home) throw new Error("Cannot resolve '~': $HOME is not set");
    return resolve(path.replace(/^~(?=$|\/|\\)/, home));
  }
  return resolve(path);
}

/**
 * Resolves the absolute source and destination paths for a manifest file entry.
 * - `from` is resolved relative to the `components` directory
 * - `to` is resolved with ~ expansion and normalized to an absolute path
 */
export function getResolvedConfigPaths(
  cmpName: string,
  entry: ConfigSrc,
): Pick<ConfigSrc, "from" | "to"> {
  const from = resolve("components", cmpName, entry.from);
  const to = resolveHomePath(entry.to);
  return { from, to };
}

/**
 * Performs a single file operation (copy or symlink) defined in the manifest.
 *
 * This function resolves `from` and `to` paths, and executes the appropriate method,
 * respecting optional and force flags from both the manifest and CLI.
 *
 * @param cmpName - component identifier
 * @param entry - Config entry
 * @param options.force - if true, overrides manifest `force` and always removes existing `to` path
 *
 * Behavior:
 * - skips if `optional: true` and source is missing
 * - skips with log if destination exists and `force` is false
 * - removes destination if `force` is true (cli or manifest)
 * - ensures parent directory of `to` exists
 */
export async function performFileOperation(
  cmpName: string,
  entry: ConfigSrc,
  force = false,
) {
  const { from, to } = getResolvedConfigPaths(cmpName, entry);
  const sourceStat = await Deno.stat(from).catch(() => null);

  if (!sourceStat) {
    throw new Error(`Source not found: ${from}`);
  }

  await ensureDir(new URL(".", "file://" + to).pathname);

  // respect cli --force flag whenever specified.
  const isForced = force || entry.force;
  const destExists = await Deno.lstat(to).catch(() => null);

  if (destExists) {
    if (!isForced) {
      log.skip(`Destination exists and force not set — skipping: ${to}`);
      return;
    }

    // forced, so remove dest config!
    await Deno.remove(to, { recursive: true }).catch(log.error);
  }

  if (entry.method === "copy") {
    await copy(from, to, { overwrite: true });
    return;
  }

  // symlink by default.
  const sourceType = sourceStat.isDirectory ? "dir" : "file";
  await Deno.symlink(from, to, { type: sourceType });
}
