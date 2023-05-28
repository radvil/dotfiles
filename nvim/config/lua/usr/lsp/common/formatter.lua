local M = {}
local utils = require("utils")

---@type LspFormatOnSaveConfig
M.opts = vim.tbl_deep_extend("force", {
  enabled = true,
  notify = true,
  keymap = "<Leader>uf",
  command = "LspToggleFormatOnSave",
}, rvim.lsp.formatonsave)

function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.opts.enabled = true
  else
    M.opts.enabled = not M.opts.enabled
  end
  if M.opts.enabled then
    utils.info("Autoformat » Enabled", { title = "Lsp" })
  else
    utils.warn("Autoformat » Disabled", { title = "Lsp" })
  end
end

---@param opts? {force?:boolean}
function M.format(opts)
  if vim.b.autoformat == false and not (opts and opts.force) then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local formatters = M.get_formatters(bufnr)
  local client_ids = vim.tbl_map(function(client)
    return client.id
  end, formatters.active)

  if #client_ids == 0 then
    return
  end

  if M.opts.notify then
    M.notify(formatters)
  end

  local params = utils.opts("nvim-lspconfig").format or {}
  vim.lsp.buf.format(vim.tbl_deep_extend("force", {
    bufnr = bufnr,
    filter = function(client)
      return vim.tbl_contains(client_ids, client.id)
    end,
  }, params))
end

---@param formatters FormattersParams
function M.notify(formatters)
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

-- Gets all lsp clients that support formatting.
-- When a null-ls formatter is available for the current filetype,
-- only null-ls formatters are returned.
function M.get_formatters(bufnr)
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
    if M.supports_format(client) then
      if (#null_ls > 0 and client.name == "null-ls") or #null_ls == 0 then
        table.insert(ret.active, client)
      else
        table.insert(ret.available, client)
      end
    end
  end

  return ret
end

-- Gets all lsp clients that support formatting
-- and have not disabled it in their client config
---@param client lsp.Client
function M.supports_format(client)
  if
      client.config
      and client.config.capabilities
      and client.config.capabilities.documentFormattingProvider == false
  then
    return false
  end
  return client.supports_method("textDocument/formatting") or client.supports_method("textDocument/rangeFormatting")
end

---create user commands based on user's provided commands
function M.register_user_commands()
  vim.api.nvim_create_user_command(M.opts.command, function()
    M.toggle()
  end, {})
end

function M.register_user_keymaps()
  local function fmtcmd(name)
    return string.format("<Cmd>%s<CR>", name)
  end
  vim.keymap.set("n", M.opts.keymap, fmtcmd(M.opts.command), {
    desc = "Toggle » LSP Autoformat",
  })
end

function M.setup()
  M.register_user_commands()
  M.register_user_keymaps()
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspAutoFormat", {}),
    callback = function()
      if M.opts.enabled then
        M.format()
      end
    end,
  })
end

return M
