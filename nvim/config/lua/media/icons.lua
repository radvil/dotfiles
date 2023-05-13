local M = {}

M.Action = {
  Modify = "●",
  ModifyAlt = "",
  Close = "",
  CloseAlt = "",
  Check = "",
  Select = "",
}

M.Arrow = {
  Left = "",
  Right = "",
}

M.Common = {
  Airplane = "✈",
  Block = "▊",
  BookMark = "",
  Bug = "",
  Calendar = "",
  Code = "",
  Cog = "⚙",
  Comment = "",
  Dashboard = "",
  Envelope = "✉",
  Evil = "",
  File = "",
  Fire = "",
  Flag = "⚐",
  FlagFilled = "⚑",
  Gear = "",
  Gears = "",
  History = "",
  List = "",
  Lock = "",
  NewFile = "",
  Note = "",
  Package = "",
  Pencil = " ",
  Pencil2 = "✎",
  Project = "",
  Scissors = "✂",
  Search = "",
  SignIn = "",
  Snowflake = "❄",
  Star = "☆",
  StarFilled = "★",
  Symlink = "",
  SymlinkArrow = "➛",
  Table = "",
}

M.Chevron = {
  Left = "<",
  LeftBig = "",
  LeftBigFilled = "",
  Right = ">",
  RightBig = "",
  RightBigFilled = "",
}

M.Circle = {
  Tiny = " ",
  Big = " ",
  BigOutline = " ",
  LeftHalf = "",
  RightHalf = "",
}

M.WebDevIcons = {
  ["guard.ts"] = {
    icon = "",
    color = "#0beb64",
    name = "AngularGuard",
  },
  ["service.ts"] = {
    icon = "",
    color = "#ebba0b",
    name = "AngularService",
  },
  ["component.ts"] = {
    icon = "",
    color = "#549FDD",
    name = "AngularComponent",
  },
  ["cmp.ts"] = {
    icon = "",
    color = "#cd1053",
    name = "AngularComponentStandalone",
  },
  ["module.ts"] = {
    icon = "",
    color = "#cd1053",
    name = "AngularModule",
  },
  ["routes.ts"] = {
    icon = "",
    color = "#6DD390",
    name = "AngularRoutes",
  },
  ["pipe.ts"] = {
    icon = "",
    color = "#62b2c6",
    name = "AngularPipe",
  },
  ["interface.ts"] = {
    icon = "ﯤ",
    color = "#448bde",
    name = "TypeScriptInterface",
  },
  ["namespace.ts"] = {
    icon = "",
    color = "#038b52",
    name = "TypeScriptNamespace",
  },
  ["store.ts"] = {
    icon = "",
    color = "#ae61e0",
    name = "AngularStore",
  },
  ["actions.ts"] = {
    icon = "",
    color = "#d52f2f",
    name = "StoreActions",
  },
  ["selectors.ts"] = {
    icon = "",
    color = "#ebba0b",
    name = "StoreSelectors",
  },
  ["effects.ts"] = {
    icon = "",
    color = "#448bde",
    name = "StoreEffects",
  },
  ["angular.json"] = {
    icon = "",
    color = "#d52f2f",
    name = "AngularJson",
  },
}

M.Diagnostics = {
  Error = " ",
  Hint = " ",
  Info = " ",
  Warn = " ",
}

M.Folder = {
  ArrowOpened   = "",
  ArrowClosed   = "",
  Default       = "",
  Opened        = "",
  Empty         = "",
  EmptyOpened   = "",
  Symlink       = "",
  SymlinkOpened = "",
}

M.Git = {
  BranchAlt = "",
  Unstaged = "✗",
  Staged = "✓",
  Unmerged = "",
  Renamed = "➜",
  Deleted = "",
  DeletedFilled = "",
  Untracked = "",
  UntrackedFilled = "",
  Ignored = "◌",
}

M.KindIcons = {
  Copilot = " ",
  Array = " ",
  Boolean = "◩ ",
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Namespace = " ",
  Null = "ﳠ ",
  Number = " ",
  Object = " ",
  Operator = " ",
  Package = " ",
  Property = " ",
  Reference = " ",
  Snippet = "﬌ ",
  String = " ",
  Struct = " ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

M.Lsp = {
  server_installed = "✓",
  server_pending = "➜",
  server_uninstalled = "✗",
}

M.Misc = {
  Horse = "♞",
  Lightbulb = "",
  Squirrel = " ",
  Telescope = "",
  YinYang = "☯",
  Vim = " ",
}

M.SpinnerFrames = {
  "⠋ ",
  "⠙ ",
  "⠹ ",
  "⠸ ",
  "⠼ ",
  "⠴ ",
  "⠦ ",
  "⠧ ",
  "⠇ ",
  "⠏ ",
}

M.SpinnerFramesAlt = {
  "🌑 ",
  "🌒 ",
  "🌓 ",
  "🌔 ",
  "🌕 ",
  "🌖 ",
  "🌗 ",
  "🌘 ",
}

return M
