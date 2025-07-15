import { colors as c } from "@cliffy/ansi/colors";

export const log = {
  title: (...msg: string[]) => {
    const pfx = c.blue.bold("[🐧]");
    return console.log(`\n${pfx}`, c.blue(msg.join(" ")), "\n");
  },
  info: (...msg: string[]) => {
    const pfx = c.blue.bold("[INFO]");
    return console.log(`\n${pfx}`, c.blue(msg.join(" ")), "\n");
  },
  success: (...msg: string[]) => {
    const pfx = c.bgGreen.brightWhite.bold("[SUCCESS]");
    return console.log(`\n${pfx}`, c.green(msg.join(" ")), "\n");
  },
  action: (...msg: string[]) => {
    const pfx = c.bgCyan.black.bold("[ACTION]");
    return console.log(`\n${pfx}`, c.cyan(msg.join(" ")), "\n");
  },
  warn: (...msg: string[]) => {
    const prefix = c.bgYellow.black.bold(" WARN ");
    return console.log(`\n${prefix}`, c.yellow(msg.join(" ")));
  },
  error: (...msg: string[]) => {
    const prefix = c.bgRed.white.bold("[ERROR]");
    return console.log(`\n${prefix}`, c.red(msg.join(" ")), "\n");
  },
  dryRun: (exec = true) => {
    if (!exec) return;
    const prefix = c.yellow.black.bold("[DRY-RUN]");
    return console.log(`${prefix}`, c.gray("No changes applied..."));
  },
  skip: (...msg: string[]) => {
    const pfx = c.cyan.bold("[SKIP]");
    return console.log(`\n${pfx}`, ...msg, "\n");
  },
};
