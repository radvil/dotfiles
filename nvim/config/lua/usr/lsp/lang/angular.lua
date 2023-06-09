local function get_server_options()
  local util = require("lspconfig").util
  local root_files = { "angular.json" }
  local fback_root_files = { "nx.json", "workspace.json" }
  return {
    single_file_support = false,
    capabilities = require("usr.lsp.common.utils").get_capabilities(),
    root_dir = function(fname)
      local original = util.root_pattern(unpack(root_files))(fname)
      local fallback = util.root_pattern(unpack(fback_root_files))(fname)
      return original or fallback
    end,
    on_attach = function(client, buffer)
      client.server_capabilities.renameProvider = false
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      require("usr.lsp.common.utils").on_attach(client, buffer)
    end,
  }
end

---@type LazySpec[]
return {
  {
    "radvil2/nvim-treesitter-angular",
    branch = "jsx-parser-fix",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "neovim/nvim-lspconfig",
    ---@type RvimLspOptions
    opts = {
      servers = {
        angularls = get_server_options,
      },
    },
  }
}
