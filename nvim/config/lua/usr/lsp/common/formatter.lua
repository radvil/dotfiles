local M = {}

M.opts = {
  formatonsave = rnv.opt.lsp_formatonsave,
  notifyformat = rnv.opt.notify_on_format,
}

local function toggle_formatonsave()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.opts.formatonsave = true
  else
    M.opts.formatonsave = not M.opts.formatonsave
  end
  if M.opts.formatonsave then
    require("utils").info("Document » Autoformat Enabled", { title = "LSP" })
  else
    require("utils").warn("Document » Autoformat Disabled", { title = "LSP" })
  end
end

---@param formatters FormattersParams
local function notify_onformat(formatters)
  local lines = { "# Active:" }
  for _, client in ipairs(formatters.active) do
    local line = "- **" .. client.name .. "**"
    if client.name == "null-ls" then
      line = line
          .. " ("
          .. table.concat(
            vim.tbl_map(function(f)
              return "`" .. f.name .. "`"
            end, formatters.null_ls),
            ", "
          )
          .. ")"
    end
    table.insert(lines, line)
  end
  if #formatters.available > 0 then
    table.insert(lines, "")
    table.insert(lines, "# Disabled:")
    for _, client in ipairs(formatters.available) do
      table.insert(lines, "- **" .. client.name .. "**")
    end
  end
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, {
    title = "Formatting",
    on_open = function(win)
      vim.api.nvim_win_set_option(win, "conceallevel", 3)
      vim.api.nvim_win_set_option(win, "spell", false)
      local buf = vim.api.nvim_win_get_buf(win)
      vim.treesitter.start(buf, "markdown")
    end,
  })
end

-- Gets all lsp clients that support formatting
-- and have not disabled it in their client config
---@param client lsp.Client
local function supports_format(client)
  if
      client.config
      and client.config.capabilities
      and client.config.capabilities.documentFormattingProvider == false
  then
    return false
  end
  return client.supports_method("textDocument/formatting") or client.supports_method("textDocument/rangeFormatting")
end

-- Gets all lsp clients that support formatting.
-- When a null-ls formatter is available for the current filetype,
-- only null-ls formatters are returned.
local function get_formatters(bufnr)
  local ft = vim.bo[bufnr].filetype
  local null_ls = package.loaded["null-ls"] and require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") or {}
  ---@class FormattersParams
  local ret = {
    ---@type lsp.Client[]
    active = {},
    ---@type lsp.Client[]
    available = {},
    null_ls = null_ls,
  }
  ---@type lsp.Client[]
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if supports_format(client) then
      if (#null_ls > 0 and client.name == "null-ls") or #null_ls == 0 then
        table.insert(ret.active, client)
      else
        table.insert(ret.available, client)
      end
    end
  end
  return ret
end

---@param opts? {force?:boolean}
local function format_document(opts)
  if vim.b.autoformat == false and not (opts and opts.force) then
    return
  end
  local bufnr = vim.api.nvim_get_current_buf()
  local formatters = get_formatters(bufnr)
  local client_ids = vim.tbl_map(function(client)
    return client.id
  end, formatters.active)
  if #client_ids == 0 then
    return
  end
  if M.opts.notifyformat then
    notify_onformat(formatters)
  end
  local params = require("utils").opts("nvim-lspconfig").format or {}
  vim.lsp.buf.format(vim.tbl_deep_extend("force", {
    bufnr = bufnr,
    filter = function(client)
      return vim.tbl_contains(client_ids, client.id)
    end,
  }, params))
end

M.api = {
  toggle_formatonsave = toggle_formatonsave,
  format_document = format_document,
  supports_format = supports_format,
  notify_onformat = notify_onformat,
  get_formatters = get_formatters,
}

function M.setup()
  -- register toggle event
  vim.api.nvim_create_user_command("RnvLspToggleAutoFormat", function()
    toggle_formatonsave()
  end, {})
  --- register toggle keymaps
  vim.keymap.set("n", "<c-z>f", toggle_formatonsave, {
    desc = "Toggle » Document format on save",
  })
  --- listen on format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("RnvLspAutoFormat", {}),
    callback = function()
      if M.opts.formatonsave then
        format_document()
      end
    end,
  })
end

return M
