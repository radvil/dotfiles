local M = {}

M.treesitter = {
  "radvil2/nvim-treesitter-angular",
  dependencies = "nvim-treesitter/nvim-treesitter",
  branch = "jsx-parser-fix",
}

function M.get_server_opts()
  local util = require("lspconfig").util
  local root_files = { "angular.json" }
  local fback_root_files = { "nx.json", "workspace.json" }
  return {
    single_file_support = false,
    capabilities = require("usr.lsp.common.utils").get_capabilities(),
    on_attach = function(client, buffer)
      client.server_capabilities.renameProvider = false
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      require("usr.lsp.common.utils").on_attach(client, buffer)
    end,
    root_dir = function(fname)
      local original = util.root_pattern(unpack(root_files))(fname)
      local fallback = util.root_pattern(unpack(fback_root_files))(fname)
      return original or fallback
    end,
  }
end

return M
