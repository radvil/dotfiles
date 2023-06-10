---@type LazySpec[]
return {
  "neovim/nvim-lspconfig",
  ---@type rvnLspOptions
  opts = {
    servers = {
      emmet_ls = {
        single_file_support = true,
        on_attach = function(client, buffer)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          require("usr.lsp.common.utils").on_attach(client, buffer)
        end
      }
    },
  },
}
