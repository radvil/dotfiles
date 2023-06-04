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
    desc = "Lsp » Next diagnostic ref",
  },
  {
    "[d",
    diag_goto(false),
    desc = "Lsp » Prev diagnostic ref",
  },
  {
    "]e",
    diag_goto(true, "ERROR"),
    desc = "Lsp » Next error ref",
  },
  {
    "[e",
    diag_goto(false, "ERROR"),
    desc = "Lsp » Prev error ref",
  },
  {
    "]w",
    diag_goto(true, "WARN"),
    desc = "Lsp » Next warning",
  },
  {
    "[w",
    diag_goto(false, "WARN"),
    desc = "Lsp » Next warning",
  },
  {
    "gh",
    vim.lsp.buf.hover,
    desc = "Lsp » Hover",
  },
  {
    "gd",
    "<Cmd>CD<Cr>",
    desc = "Lsp » Goto to definition",
  },
  {
    "ga",
    "<Cmd>CA<Cr>",
    mode = { "n", "v" },
    has = "codeAction",
    desc = "Lsp » Code action",
  },
  {
    "gf",
    "<Cmd>CF<Cr>",
    has = "documentFormatting",
    desc = "Lsp » Format document",
  },
  {
    "gf",
    "<Cmd>CF<Cr>",
    has = "documentRangeFormatting",
    desc = "Lsp » Format selection",
    mode = "v",
  },
  {
    "gr",
    "<Cmd>CR<Cr>",
    has = "rename",
    desc = "Lsp » Rename under cursor",
  },
  {
    "<F2>",
    "<Cmd>CR<Cr>",
    has = "rename",
    desc = "Lsp » Rename under cursor",
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
