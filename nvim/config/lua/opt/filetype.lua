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
  "edgy"
}

M.treesitter = {
  "bash",
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

M.popups = {
  "DressingInput",
  "lazy",
  "lspinfo",
  "mason",
  "neo-tree-popup",
  "notify",
  "oil",
  "prompt",
  "TelescopePrompt",
  "TelescopeResults",
  "WhichKey",
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
  -- "TelescopePrompt",
  "TelescopeResults",
  "WhichKey",
  unpack(M.sidebars),
  unpack(M.popups)
}

M.builtin_plugins_excludes = {
  "2html_plugin",
  "bugreport",
  "compiler",
  "ftplugin",
  "fzf",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "matchit",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "optwin",
  "rplugin",
  "rrhelper",
  "spellfile_plugin",
  "synmenu",
  "syntax",
  "tar",
  "tarPlugin",
  "tohtml",
  "tutor",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "ruby",
  "gem"
}

return M
