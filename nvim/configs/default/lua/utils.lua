local M = {}

---check buffer against given mapping list or string
---@param bufnr integer | nil
---@param mappings table | string
function M.buf_has_keymaps(mappings, mode, bufnr)
  local ret = false
  bufnr = bufnr or 0
  mode = mode or "n"
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return ret
  end
  mappings = (type(mappings) == "table" and mappings) or (type(mappings) == "string" and { mappings }) or {}
  local buf_keymaps = vim.api.nvim_buf_get_keymap(bufnr, mode)
  for _, value in ipairs(mappings) do
    if not not vim.tbl_contains(buf_keymaps, value) then
      ret = true
      break
    end
  end
  return ret
end

---@param ... any
---@return any | false
function M.call(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  else
    return false
  end
end

-- function open_in_float_window()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local winnr = vim.api.nvim_get_current_win()
--   local width = vim.api.nvim_win_get_width(winnr)
--   local height = vim.api.nvim_win_get_height(winnr)
--   local row = vim.api.nvim_win_get_cursor(winnr)[1]
--   local col = vim.api.nvim_win_get_cursor(winnr)[2]
--   local opts = {
--     relative = "editor",
--     width = width,
--     height = height,
--     row = row,
--     col = col,
--     style = "minimal",
--     border = "single",
--   }
--   local float_win = vim.api.nvim_open_win(bufnr, true, opts)
--   vim.api.nvim_win_set_option(float_win, "winhl", "Normal:Normal")
--   vim.api.nvim_win_set_option(float_win, "winblend", 10)
-- end

return M
