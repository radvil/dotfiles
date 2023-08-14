---@type LazySpec[]
return {
  "neovim/nvim-lspconfig",
  ---@type PluginLspOpts
  opts = {
    servers = {
      emmet_ls = {
        single_file_support = true,
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
    },
  },
}
