---@class Preferences
local M = {
  transparent = false,
  note_dir = vim.fn.expand("~") .. "/Documents/obsidian-vault",
  snippet_dirs = {
    os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
    os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
  },
  palette = {
    bg = "#1E1E2E",
    bg2 = "#2F334D",
    fg = "#ffffff",
    blue2 = "#51AFEF",
    pink = "#ff007c",
    yellow = "#ffc777",
  },
  icons = {
    Git = {
      Added = "",
      Deleted = "",
      Modified = "",
      Renamed = "",
      Staged = "",
      Unstaged = "󰅗",
      Untracked = "",
      Conflict = "",
      Ignored = "",
    },
  },
}

return M
