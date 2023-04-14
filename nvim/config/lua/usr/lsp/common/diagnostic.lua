local M = {}
local util = require("utils")
local icons = require("media.icons")

---@class RxLspDiagnosticsSpecs
M.specs = {
  enabled = true,
  icons = icons.Diagnostics,
  commands = {
    toggle = "RvimToggleLspDiagnostics",
  },
  keymaps = {
    toggle = "<Leader>ud",
  },
  opts = {
    update_in_insert = false,
    severity_sort = true,
    underline = false,
    float = {
      border = 'rounded',
      source = 'always'
    },
    virtual_text = {
      prefix = icons.Misc.Squirrel,
      spacing = 4,
    },
  },
}

---@param section string
function M:merge_specs(section)
  if type(M.specs[section]) == "boolean" or type(M.specs[section]) == "string" then
    M.specs[section] = section or M.specs[section]
  elseif type(M.specs[section]) == "table" then
    M.specs[section] = vim.tbl_deep_extend("force", M.specs[section], rvim.lsp.diagnostics[section])
  else
    error("Invalid value for rvim spec: " .. section)
  end
end

---toggle workspace diagnostics
---@param value boolean | nil
local function toggle_diagnostics(value)
  M.specs.enabled = value or not M.specs.enabled
  local opt = { title = "Diagnostics" }
  if M.specs.enabled then
    vim.diagnostic.enable()
    util.info("[🤖 Diagnostics] enabled!", opt)
  else
    vim.diagnostic.disable()
    util.warn("[🤖 Diagnostics] disabled!", opt)
  end
end

function M:register_usercmd()
  M:merge_specs("commands")
  vim.api.nvim_create_user_command(M.specs.commands.toggle, function()
    toggle_diagnostics()
  end, {})
end

---register keymaps to handle lsp diagnostic
function M:register_keymaps()
  M:merge_specs("keymaps")
  local kmp = M.specs.keymaps
  local cmd = M.specs.commands
  vim.keymap.set("n", kmp.toggle, util.fmtcmd(cmd.toggle), {
    desc = "🤖 Toggle diagnostics",
  })
end

function M:override_builtins()
  M:merge_specs("icons")
  for name, icon in pairs(M.specs.icons) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, {
      texthl = name,
      text = icon,
      numhl = "",
    })
  end
  M:merge_specs("opts")
  vim.diagnostic.config(M.specs.opts)

  -- Override float windows handlers styles
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
  M:merge_specs("enabled")
  M:override_builtins()
  M:register_usercmd()
  M:register_keymaps()
end

return M
