local M = {}
local util = require("utils")
local icons = require("media.icons")

M.specs = {
  enabled = true,
  icons = icons.Diagnostics,
  commands = {
    toggle = "RvnToggleLspDiagnostics",
  },
  keymaps = {
    toggle = "<Leader>ud",
  },
  opts = {
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
      prefix = icons.Misc.Squirrel,
      spacing = 4,
    },
  },
}

---@param value boolean | nil
local function toggle_diagnostics(value)
  M.specs.enabled = value or not M.specs.enabled
  if M.specs.enabled then
    vim.diagnostic.enable()
    util.info("Diagnostics » Enabled", { title = "LSP" })
  else
    vim.diagnostic.disable()
    util.warn("Diagnostics » Disabled", { title = "LSP" })
  end
end

function M.override_builtins()
  for name, icon in pairs(M.specs.icons) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, {
      texthl = name,
      text = icon,
      numhl = "",
    })
  end
  vim.diagnostic.config(M.specs.opts)
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
  )
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
  )
end

function M.setup()
  M.override_builtins()
  vim.api.nvim_create_user_command(M.specs.commands.toggle, function()
    toggle_diagnostics()
  end, {})

  local kmp = M.specs.keymaps
  local cmd = M.specs.commands
  vim.keymap.set("n", kmp.toggle, util.fmtcmd(cmd.toggle), {
    desc = "Diagnostics » Toggle",
  })
end

return M
