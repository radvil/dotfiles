---@type LazySpec
local M = {}
M[1] = "neovim/nvim-lspconfig"
M.enabled = true
M.event = { "BufReadPre", "BufNewFile" }

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

---@class rvnLspOptions
M.opts = {
  install_missing_servers = true,
  ---NOTE: set value to false to prevent autoinstall servers
  servers = {
    ["jsonls"] = true,
    ["bashls"] = true,
    ["html"] = {},
    ["cssls"] = {},
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
        typescript = {
          format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
          },
        },
        javascript = {
          format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
          },
        },
        completions = {
          completeFunctionCalls = true,
        },
      },
    },
  },
}

local function get_defaults()
  return {
    capabilities = require("usr.lsp.common.utils").get_capabilities(),
    on_attach = require("usr.lsp.common.utils").on_attach,
  }
end

---@param options rvnLspOptions
local setup_language_servers = function(options)
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

---@param opts rvnLspOptions
M.config = function(_, opts)
  require("usr.lsp.common.diagnostic").setup()
  require("usr.lsp.common.formatter").setup()
  setup_language_servers(opts)
end

return M
