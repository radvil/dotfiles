local M = {}

function M.get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  local nvim_cmp = Call("cmp_nvim_lsp")
  if nvim_cmp then
    capabilities = nvim_cmp.default_capabilities(capabilities)
  end
  return capabilities
end

M.on_attach = function(client, buffer)
  require("usr.lsp.common.formatter").attach_to_client(client, buffer)
  require("usr.lsp.common.keymaps").attach_to_client(client, buffer)
  if client.server_capabilities["documentSymbolProvider"] then
    if require("utils").has("nvim-navic") then
      require("nvim-navic").attach(client, buffer)
    end
  end
end

function M.get_default_server_options()
  return {
    capabilities = M.get_capabilities(),
    on_attach = M.on_attach,
  }
end

return M
