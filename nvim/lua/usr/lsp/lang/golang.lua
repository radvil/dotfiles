local M = {}

function M.get_server_opts()
  local root_pattern = require("lspconfig").util.root_pattern
  local util = require("usr.lsp.common.utils")
  return {
    single_file_support = true,
    root_dir = root_pattern("go.work", "go.mod", ".git"),
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    capabilities = util.get_capabilities(),
    on_attach = function(client, bufnr)
      util.on_attach(client, bufnr)
    end,
  }
end

return M
