---@desc: language service provider
---@type LazySpec
local M = {}

M[1] = "neovim/nvim-lspconfig"

M.event = "BufReadPre"

M.dependencies = {
  "mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    config = true,
  },
  {
    "folke/neodev.nvim",
    opts = {
      experimental = {
        pathStrict = true,
      },
    },
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    cond = function()
      return require("utils").has("nvim-cmp")
    end,
  },
}

---@class RvimLspOptions
M.opts = {
  install_missing_servers = true,
  ---set to false if dont wanna auto install server
  servers = {
        ["jsonls"] = true,
        ["bashls"] = true,
        ["html"] = {},
        ["lua_ls"] = {},
        ["cssls"] = {},
        ["tsserver"] = {},
        ["rust_analyzer"] = {},
        ["emmet_ls"] = {},
        ["angularls"] = function()
      return require("usr.lsp.lang.angularls").get_server_opts()
    end,
    -- ["gopls"] = vim.fn.executable("go") ~= 1 and false or function()
    --   return require("usr.lsp.lang.golang").get_server_opts()
    -- end,
  },
}

---@desc setup default servers and attach default handlers
---@param options RvimLspOptions
local setup_servers = function(options)
  local ensure_installed = {}

  ---@param opts function | table | boolean
  for server, opts in pairs(options.servers) do
    local default_opts = require("usr.lsp.common.utils").get_default_server_options()
    if type(opts) == "boolean" and opts == false then
      opts = default_opts
    else
      -- TODO: remove unlisted servers after being removed from the quicksettings
      ensure_installed[#ensure_installed + 1] = server
      if type(opts) == "function" then
        opts = opts() or default_opts
      elseif type(opts) == "table" then
        opts = vim.tbl_deep_extend("force", default_opts, opts or {})
      else
        opts = default_opts
      end
    end
    require("lspconfig")[server].setup(opts)
  end

  require("mason-lspconfig").setup({
    automatic_installation = options.install_missing_servers,
    ensure_installed = ensure_installed,
  })
end

---@param opts RvimLspOptions
M.config = function(_, opts)
  require("usr.lsp.common.diagnostic").setup()
  require("usr.lsp.common.formatter").setup()
  setup_servers(opts)
end

return M
