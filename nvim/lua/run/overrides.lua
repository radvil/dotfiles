local M = {}

function M:reset_keys()
  --TODO: define to quick settings
  local opts = { silent = true, noremap = true }
  vim.keymap.set("", "<C-z><C-z>", "", opts)
  vim.keymap.set({ "n", "x", "v" }, "q", "<Nop>", opts)
  vim.keymap.set({ "n", "x", "v" }, "Q", "<Nop>", opts)
  vim.keymap.set({ "n", "x", "v" }, "<NL>", "<Nop>", opts)
  -- vim.keymap.set({ "n", "x", "v" }, "<C-w>", "<Nop>", opts)
  -- vim.keymap.set({ "n", "x", "v" }, "<C-F>", "<Nop>", opts)
  -- vim.keymap.set({ "n", "x", "v" }, "<C-B>", "<Nop>", opts)
  vim.keymap.set("n", "<A-Cr>", "<Nop>", opts)
  vim.keymap.set("i", "<A-Bs>", "<Nop>", opts)
  vim.keymap.set("i", "<C-D>", "<Nop>", opts)
  if rvim and rvim.g.mapleader ~= nil then
    -- vim.keymap.set({ "n", "x", "v" }, rvim.g.mapleader, "<Nop>", opts)
    vim.g.mapleader = rvim.g.mapleader
    vim.g.maplocalleader = rvim.g.maplocalleader
  else
    -- vim.keymap.set({ "n", "x", "v" }, " ", "<Nop>", opts)
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
  end
  Log("reset bulitin keymaps!", "^ RUN")
end

---@param changes table | nil
function M:override_base(changes)
  for opt, value in
  pairs(vim.tbl_extend("force", {
    wildignore =
    ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
    -- backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
    -- diffopt = "internal,filler,closeoff,algorithm:patience,iwhiteall",
    spellfile = rvim.path.cache .. "/spell/en.uft-8.add",
    backupdir = rvim.path.cache .. "/backup/",
    directory = rvim.path.cache .. "/swag/",
    undodir = rvim.path.cache .. "/undo/",
    viewdir = rvim.path.cache .. "/view/",
    shada = "!,'300,<50,@100,s10,h",
    fileencoding = "utf-8",
    encoding = "utf-8",
  }, changes or {}))
  do
    vim.opt[opt] = value
  end
  -- vim.cmd('let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"')
  -- vim.cmd('let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"')
  Log("override base!", "^ RUN")
end

---@param changes table | nil
function M:override_globals(changes)
  for opt, value in
  pairs(vim.tbl_extend("force", {
    override_nvim_web_devicons = false,
    markdown_syntax_conceal = false,
    vim_json_syntax_conceal = false,
    mkdp_auto_start = false,
    one_allow_italics = true,
    table_mode_corner = "|",
  }, changes or {}))
  do
    vim.g[opt] = value
  end
  Log("override globals!", "^ RUN")
end

---@param props table | nil
function M.disable_builtin_plugins(props)
  for _, plugin in
  ipairs(vim.tbl_extend("force", {
    "2html_plugin",
    "bugreport",
    "compiler",
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
    "tar",
    "tarPlugin",
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
function M.disable_builtin_providers(props)
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
  M:override_base()
  M:override_globals()
  M:disable_builtin_plugins()
  M:disable_builtin_providers()
end

M.setup()

return M
