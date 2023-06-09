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
      return require("common.utils").has("nvim-cmp")
    end,
  },
}

---@class RvnLspOptions
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
            workspaceWord = true,
            callSnippet = "Replace",
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable"
          },
          -- doc = {
          --   privateName = { "^_" }
          -- },
          -- type = {
          --   castNumberToInterger = true,
          -- },
          -- diagnostics = {
          --   disable = {
          --     "incomplete-signature-doc",
          --     "trailing-space"
          --   },
          --   groupSeverity = {
          --     strong = "Warning",
          --     strict = "Warning"
          --   },
          --   groupFileStatus = {
          --     ["ambiguity"] = "Opened",
          --     ["await"] = "Opened",
          --     ["codestyle"] = "None",
          --     ["duplicate"] = "Opened",
          --     ["global"] = "Opened",
          --     ["luadoc"] = "Opened",
          --     ["redefined"] = "Opened",
          --     ["strict"] = "Opened",
          --     ["strong"] = "Opened",
          --     ["type-check"] = "Opened",
          --     ["unbalanced"] = "Opened",
          --     ["unused"] = "Opened",
          --   },
          -- }
        },
      },
    },
    ["tsserver"] = {
      root_dir = function(...)
        return require("lspconfig.util").root_pattern(".git")(...)
      end,
      single_file_support = false,
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
    capabilities = require("common.lsp").make_client_capabilities(),
    on_attach = require("common.lsp").default_on_attach,
  }
end

---@param options RvnLspOptions
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

---@param opts RvnLspOptions
M.config = function(_, opts)
  require("common.lsp").register_user_cmds()
  require("common.diagnostic").setup()
  require("common.formatter").setup()
  setup_language_servers(opts)
end

return M
