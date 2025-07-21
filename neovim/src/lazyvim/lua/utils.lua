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

---Checks if a given command is available in the system's PATH.
---@param cmd (string) The name of the command to check for (e.g., "bash", "fish").
---@return (boolean) true if the command exists, false otherwise.
function M.command_exists(cmd)
  if vim.fn.executable then
    return vim.fn.executable(cmd) == 1
  end
  if not cmd or type(cmd) ~= "string" then
    error("Invalid command: expected a string, got " .. type(cmd))
  end
  local f = io.popen("which " .. cmd .. " 2>/dev/null")
  if not f then
    return false
  end
  local result = f:read("*a")
  f:close()
  return result ~= ""
end

---Reload available theme. Usually after option(s) changed.
---@param cb (function) callback function
M.reload_theme = function(cb)
  return function()
    if type(cb) ~= "function" then
      return
    end
    local colors_name = vim.g.colors_name
    for _, value in ipairs({
      "tokyonight",
      "catppuccin",
      "monokai-pro",
      "kanagawa",
      "onedark",
      "material",
      "rose-pine",
    }) do
      if string.match(colors_name, value) then
        cb()
        vim.cmd.Lazy("reload " .. value)
        vim.schedule(function()
          vim.cmd.colorscheme(colors_name)
        end)
        break
      end
    end
  end
end

return M
