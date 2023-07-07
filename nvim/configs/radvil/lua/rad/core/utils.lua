local M = {}

M._dev = true

---@param ... any
---@return any | nil
function M.call(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  else
    return nil
  end
end

---@param plugin string
function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

function M.log(msg, opts)
  if not M._dev then
    return
  end
  opts = vim.tbl_deep_extend("force", {
    severity = vim.log.levels.INFO,
    title = "LOG",
  }, opts or {})
  local title = string.format("[%s]", opts.title)
  local hl = opts.severity == vim.log.levels.INFO and "Type" or "Label"
  vim.api.nvim_echo({
    { title, hl },
    { " » " .. msg },
  }, true, {})
end

return M
