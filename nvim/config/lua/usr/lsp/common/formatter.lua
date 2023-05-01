local M = {}
local utils = require("utils")

local opts = vim.tbl_deep_extend("force", {
  enabled = true,
  command = "RvimLspToggleFormatonsave",
  keymap = "<Leader>uf",
}, rvim.lsp.formatonsave)

---toggle global formatonsave
function M:toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    opts.enabled = true
  else
    opts.enabled = not opts.enabled
  end
  if opts.enabled then
    utils.info("Autoformat » Enabled", { title = "Codes" })
  else
    utils.warn("Autoformat » Disabled", { title = "Codes" })
  end
end

---format callback
---@param bufnr integer | nil
function M:format(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if vim.b.autoformat == false then
    return
  end
  local ft = vim.bo[bufnr].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0
  local custom_params = utils.opts("nvim-lspconfig").format or {}
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      return have_nls and client.name == "null-ls" or client.name ~= "null-ls"
    end,
    unpack(custom_params),
  })
end

---attach formatter on lsp client
---@param client any
---@param bufnr integer | nil
function M.attach_to_client(client, bufnr)
  if
      client.config
      and client.config.capabilities
      and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
      buffer = bufnr,
      callback = function()
        if opts.enabled then
          M:format(bufnr)
        end
      end,
    })
  end
end

---create user commands based on user's provided commands
function M:register_user_commands()
  vim.api.nvim_create_user_command(opts.command, function()
    M:toggle()
  end, {})
end

function M:register_user_keymaps()
  local kmp = opts.toggle_keymap
  local cmd = opts.command
  local function fmtcmd(name)
    return string.format("<Cmd>%s<CR>", name)
  end
  vim.keymap.set("n", kmp, fmtcmd(cmd), {
    desc = "Toggle » LSP Autoformat",
  })
end

function M.setup()
  M:register_user_commands()
  M:register_user_keymaps()
end

return M
