local M = {}

function M:reset_keys()
  local opts = { silent = true, noremap = true }
  vim.keymap.set("", "<C-z><C-z>", "<Nop>", opts)
  vim.keymap.set({ "n", "x", "v" }, "<NL>", "<Nop>", opts)
  vim.keymap.set("n", "<A-Cr>", "<Nop>", opts)
  vim.keymap.set("i", "<A-Bs>", "<Nop>", opts)
  vim.keymap.set("i", "<C-D>", "<Nop>", opts)
  if rvim and rvim.g.mapleader ~= nil then
    vim.g.mapleader = rvim.g.mapleader
    vim.g.maplocalleader = rvim.g.maplocalleader
  else
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
  end
  Log("reset bulitin keymaps!", "^ RUN")
end

---@param props table | nil
function M:disable_builtin_plugins(props)
  for _, plugin in
  ipairs(vim.tbl_extend("force", {
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
  }, props or {}))
  do
    vim.g["loaded_" .. plugin] = 1
  end
  Log("disable builtin plugins!", "^ RUN")
end

---@param props table | nil
function M:disable_builtin_providers(props)
  for _, provider in
  ipairs(vim.tbl_extend("force", {
    "perl",
    "ruby",
  }, props or {}))
  do
    vim.g["loaded_" .. provider .. "_provider"] = 0
  end
  Log("disable builtin providers!", "^ RUN")
end

function M.setup()
  M:reset_keys()
  M:disable_builtin_plugins()
  M:disable_builtin_providers()
end

M.setup()

return M
