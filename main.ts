import { Command } from "@cliffy/command";
import { colors as c } from "@cliffy/ansi/colors";
import { ActionInstall } from "./actions/install.ts";
import { ActionList } from "./actions/list.ts";
import { ActionRemove } from "./actions/remove.ts";
import { ActionDebug } from "./actions/debug.ts";
import { TestFunc } from "./test-function.ts";

await new Command()
  .name("dotbox")
  .version("0.1.0")
  .description("Dotfile installer inside dorabox")
  // `deno task list`
  .command(
    "list",
    `List all available components with "${c.yellow("manifest.jsonc")}"`,
  )
  .option("--tags <tags:string>", "Show components with tagged configs")
  .option("--json", "Output in JSON format")
  .option("--table", "Display output as a table")
  .option("--sort <type:string>", "Sort by 'priority' or 'name'", {
    default: "priority",
  })
  .action(ActionList.Runner)
  // `deno task install`
  .command("install [...components:string]", "Install components by names")
  .option(
    "--components <components:string>",
    `Select specific component(s) only. E.g., ${
      c.green(
        "---components=neovim,fish",
      )
    }`,
  )
  .option(
    "--tags <tags:string>",
    "Select by tags instead of distro detection (applied to config files only)",
  )
  .option(
    "--sort <type:string>",
    `Sort by ${c.green("priority")} or ${c.green("name")}`,
    { default: "priority" },
  )
  .option("--skip-builds", "Run only file operations (skip builds/setup)")
  .option("--skip-files", "Run only builds/setup (skip file operations)")
  .option("--dry-run", "Simulate install without changes")
  .option(
    "--force",
    "Force overwrite of destination files if they already exist",
  )
  .action(ActionInstall.Runner)
  // `deno task remove`
  .command("remove <...components:string>")
  .option("--dry-run", "Simulate removal only")
  .action(ActionRemove.Runner)
  // `deno task debug`
  .command("debug <component:string>")
  .option("--id <id:string>", "distro/machine id", { default: "nobara" })
  .action(ActionDebug.Runner)
  // `deno task test-function`
  .command("test-func")
  .action(TestFunc)
  .parse(Deno.args);
