local M = {}

function M.register_user_cmds()
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
    require("usr.lsp.common.formatter").format({ force = true })
  end, {})
end

local function diag_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

---@type (LazyKeys|{has?:string})[]
M.keys = {
  {
    "]d",
    diag_goto(true),
    desc = "Next Diagnostic",
  },
  {
    "[d",
    diag_goto(false),
    desc = "Prev Diagnostic",
  },
  {
    "]e",
    diag_goto(true, "ERROR"),
    desc = "Next Error",
  },
  {
    "[e",
    diag_goto(false, "ERROR"),
    desc = "Prev Error",
  },
  {
    "]w",
    diag_goto(true, "WARN"),
    desc = "Next Warning",
  },
  {
    "[w",
    diag_goto(false, "WARN"),
    desc = "Prev Warning",
  },
  {
    "gh",
    vim.lsp.buf.hover,
    desc = "Hover",
  },
  {
    "gd",
    "<Cmd>CD<Cr>",
    desc = "Goto Definition",
  },
  {
    "ga",
    "<Cmd>CA<Cr>",
    desc = "Code Action",
    mode = { "n", "v" },
    has = "codeAction",
  },
  {
    "gf",
    "<Cmd>CF<Cr>",
    desc = "CURRENT » Format Document",
    has = "documentFormatting",
  },
  {
    "gf",
    "<Cmd>CF<Cr>",
    has = "documentRangeFormatting",
    desc = "Format Range",
    mode = "v",
  },
  {
    "gr",
    "<Cmd>CR<Cr>",
    desc = "Rename",
    has = "rename",
  },
  {
    "<F2>",
    "<Cmd>CR<Cr>",
    desc = "Rename",
    has = "rename",
  },
}

function M.attach_to_client(client, buffer)
  M.register_user_cmds()
  local Keys = require("lazy.core.handler.keys")

  ---@type table<string,LazyKeys|{has?:string}>
  local keymaps = {}
  for _, value in ipairs(M.keys) do
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

return M
