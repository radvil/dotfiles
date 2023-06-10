local M = {}

M.loaded = false

M.enabled = rnv.opt.lsp_diagnostics or false

local toggle = function()
  M.enabled = not M.enabled
  if M.enabled then
    vim.diagnostic.enable()
    require("utils").info("Diagnostics » Enabled", { title = "LSP" })
  else
    vim.diagnostic.disable()
    require("utils").warn("Diagnostics » Disabled", { title = "LSP" })
  end
end

M.api = {
  toggle = toggle
}

function M.setup()
  if M.loaded then
    rnv.api.log("Diagnostics already loaded!", "common.diagnostics")
    return
  end

  for name, icon in pairs(require("media.icons").Diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, {
      texthl = name,
      text = icon,
      numhl = "",
    })
  end

  vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    underline = true,
    float = {
      border = 'rounded',
      source = 'if_many'
    },
    virtual_text = {
      -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      -- prefix = "icons",
      prefix = require("media.icons").Misc.Squirrel,
      spacing = 4,
    },
  })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
  )

  vim.api.nvim_create_user_command("RnvLspToggleDiagnostics", function()
    M.api.toggle()
  end, {})

  vim.keymap.set("n", "<c-z>x", M.api.toggle, {
    desc = "Diagnostics » Toggle",
  })

  M.loaded = true
end

return M
