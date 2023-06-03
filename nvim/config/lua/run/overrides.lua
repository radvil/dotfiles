local M = {}

vim.g.mapleader = rvim.g.mapleader or " "
vim.g.maplocalleader = rvim.g.maplocalleader or " "

for _, plugin in ipairs({
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
})
do
  vim.g["loaded_" .. plugin] = 1
end

Log("disable builtin plugins!", "^ RUN")

for _, provider in ipairs({
  "perl",
  "ruby",
})
do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

Log("disable builtin providers!", "^ RUN")

return M
