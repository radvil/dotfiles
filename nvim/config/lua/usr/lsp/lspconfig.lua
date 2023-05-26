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
    ["lua_ls"] = {
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    },
    ["tsserver"] = {
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
      },
    },
    ["html"] = {},
    ["cssls"] = {},
    ["emmet_ls"] = {
      single_file_support = true,
      on_attach = function(client, buffer)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        require("usr.lsp.common.utils").on_attach(client, buffer)
      end
    },
    ["angularls"] = require("usr.lsp.lang.angularls").get_server_opts,
  },
}

local function get_defaults()
  return {
    capabilities = require("usr.lsp.common.utils").get_capabilities(),
    on_attach = require("usr.lsp.common.utils").on_attach,
  }
end

---@desc setup default servers and attach default handlers
---@param options RvimLspOptions
local setup_servers = function(options)
  local ensure_installed = {}

  ---@param opts function | table | boolean
  for server, opts in pairs(options.servers) do
    if type(opts) == "boolean" and opts == false then
      opts = get_defaults()
    else
      ensure_installed[#ensure_installed + 1] = server
      if type(opts) == "function" then
        opts = opts() or get_defaults()
      elseif type(opts) == "table" then
        opts = vim.tbl_deep_extend("force", get_defaults(), opts or {})
      else
        opts = get_defaults()
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
