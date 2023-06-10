local M = {}

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

---@type (LazyKeys|{has?:string})[]
local default_keys = {
  {
    "]d",
    M.diagnostic_goto(true),
    desc = "Doc diagnostic » Next reference",
  },
  {
    "[d",
    M.diagnostic_goto(false),
    desc = "Doc diagnostic » Prev reference",
  },
  {
    "]e",
    M.diagnostic_goto(true, "ERROR"),
    desc = "Doc diagnostic » Next reference (error)",
  },
  {
    "[e",
    M.diagnostic_goto(false, "ERROR"),
    desc = "Doc diagnostic » Prev reference (error)",
  },
  {
    "]w",
    M.diagnostic_goto(true, "WARN"),
    desc = "Doc diagnostic » Next reference (warn)",
  },
  {
    "[w",
    M.diagnostic_goto(false, "WARN"),
    desc = "Doc diagnostic » Prev reference (warn)",
  },
  {
    "gh",
    vim.lsp.buf.hover,
    desc = "LSP » Document hover",
  },
  {
    "gd",
    ":CD<cr>",
    desc = "LSP » Goto to definition",
  },
  {
    "ga",
    ":CA<cr>",
    mode = { "n", "v" },
    has = "codeAction",
    desc = "LSP » Code action",
  },
  {
    "gf",
    ":CF<cr>",
    has = "documentFormatting",
    desc = "LSP » Format document",
  },
  {
    "gf",
    ":CF<cr>",
    has = "documentRangeFormatting",
    desc = "LSP » Format selection",
    mode = "v",
  },
  {
    "gr",
    ":CR<cr>",
    has = "rename",
    desc = "LSP » Rename under cursor",
  },
  {
    "<F2>",
    ":CR<cr>",
    has = "rename",
    desc = "LSP » Rename under cursor",
  },
}

local register_user_cmds = function()
  vim.api.nvim_create_user_command("CR", "lua vim.lsp.buf.rename()", {})
  vim.api.nvim_create_user_command("CA", "lua vim.lsp.buf.code_action()", {})
  vim.api.nvim_create_user_command("CD", "Telescope lsp_definitions", {})
  vim.api.nvim_create_user_command("CV", vim.lsp.buf.signature_help, {})
  vim.api.nvim_create_user_command("CI", "Telescope lsp_implementations", {})
  vim.api.nvim_create_user_command("CL", "Telescope lsp_references", {})
  -- TODO: handle documentSymbolProvider as "CS"
  vim.api.nvim_create_user_command("CT", "Telescope lsp_type_definitions", {})
  vim.api.nvim_create_user_command("CX", "TroubleToggle", {})
  vim.api.nvim_create_user_command("CF", function()
    require("common.formatter").api.format_document({ force = true })
  end, {})
end

function M.attach_keymaps(client, buffer)
  register_user_cmds()
  local Keys = require("lazy.core.handler.keys")
  ---@type table<string,LazyKeys|{has?:string}>
  local keymaps = {}
  for _, value in ipairs(default_keys) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end
  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = true
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
    end
  end
end

function M.attach_symbols_handler(client, buffer)
  if client.server_capabilities["documentSymbolProvider"] then
    if require("common.utils").has("nvim-navic") then
      require("nvim-navic").attach(client, buffer)
    end
  end
end

function M.make_client_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  local nvim_cmp = rnv.api.call("cmp_nvim_lsp")
  if nvim_cmp then
    capabilities = nvim_cmp.default_capabilities(capabilities)
  end
  return capabilities
end

M.default_on_attach = function(client, buffer)
  M.attach_symbols_handler(client, buffer)
  M.attach_keymaps(client, buffer)
end

return M
