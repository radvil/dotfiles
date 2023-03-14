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
    capabilities = require("usr.lsp.common.utils").get_capabilities(),
    on_attach = function(client, buffer)
      ---@fix enabling this makes rename provider to prompt twice if we already have tsserver attached to the buffer
      client.server_capabilities.renameProvider = false
      require("usr.lsp.common.utils").on_attach(client, buffer)
    end,
    single_file_support = false,
    root_dir = function(fname)
      local original = util.root_pattern(unpack(root_files))(fname)
      local fallback = util.root_pattern(unpack(fback_root_files))(fname)
      return original or fallback
    end,
  }
end

return M
