local M = {}

M.sidebars = {
  "dbui",
  "DiffViewFiles",
  "Mundo",
  "MundoDiff",
  "NvimTree",
  "neo-tree",
  "neo-tree-popup",
  "Outline",
}

M.treesitter = {
  "bash",
  "help",
  "html",
  "javascript",
  "json",
  "jsonc",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "tsx",
  "typescript",
  "vim",
  "yaml",
}

M.excludes = {
  "dirbuf",
  "fugitive",
  "fugitiveblame",
  "gitcommit",
  "help",
  "lspinfo",
  "NeogitStatus",
  "notify",
  "packer",
  "prompt",
  "qf",
  "Dashboard",
  "dashboard",
  "Trouble",
  "alpha",
  "mason",
  "help",
  "lazy",
  "noice",
  "DressingInput",
  "TelescopePrompt",
  "TelescopeResults",
  "WhichKey",
  unpack(M.sidebars),
}

return M
