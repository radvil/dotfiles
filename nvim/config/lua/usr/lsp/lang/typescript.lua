---@type LazySpec
local M = {}
M[1] = "jose-elias-alvarez/typescript.nvim"
M.event = "BufReadPre"
M.dependencies = {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      if opts and type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "tsserver" })
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      if opts and type(opts.sources) == "table" then
        vim.list_extend(opts.sources, {
          require("typescript.extensions.null-ls.code-actions"),
        })
      end
    end,
  },
}

local function attach_keymappings(buffer)
  buffer = buffer or 0
  Map("n", "gM", ":TypescriptAddMissingImports<CR>", {
    desc = "Add missing imports",
    buffer = buffer,
  })
  Map("n", "gO", ":TypescriptOrganizeImports<CR>", {
    desc = "Add organize imports",
    buffer = buffer,
  })
  Map("n", "<F2>", ":TypescriptRenameFile<CR>", {
    buffer = buffer,
    desc = "Rename file",
  })
  Map("n", "gd", ":TypescriptGoToSourceDefinition<CR>", {
    desc = "Go to source definition",
    buffer = buffer,
  })
end

M.opts = function()
  local utils = require("usr.lsp.common.utils")
  local capabilities = utils.get_capabilities()
  return {
    server = {
      capabilities = capabilities,
      on_attach = function(client, buffer)
        utils.on_attach(client, buffer)
        attach_keymappings(buffer)
      end,
    },
  }
end

return M
