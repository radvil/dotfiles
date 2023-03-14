local env = rvim.file_explorer
local function config(name)
  return require(string.format("usr.accessibility.tree.%s", name))
end
---@type LazySpec[]
local M = { config("symbols-outline") }
if env.enabled then
  table.insert(M, config("lf"))
end
if env.fix_import_on_file_operations then
  table.insert(M, config("file-operation"))
end
if env.sidebar_tree.enabled then
  table.insert(M, config(env.sidebar_tree.provider))
end
return M
