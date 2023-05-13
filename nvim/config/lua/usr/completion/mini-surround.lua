---@desc surround
---@type LazySpec
local M = {}
M[1] = "echasnovski/mini.surround"
M.opts = {
  mappings = {
    add = "so",
    delete = "sd",
    find = "sn",
    find_left = "sp",
    highlight = "sh",
    replace = "ss",
    update_n_lines = "",
  },
}
---@diagnostic disable-next-line: assign-type-mismatch
M.keys = function(plugin, keys)
  local opts = require("lazy.core.plugin").values(plugin, "opts", false)
  local mode = { "n", "x" }
  local mappings = {
    { opts.mappings.add,       desc = "Open/Add",               mode = mode },
    { opts.mappings.delete,    desc = "Delete",                 mode = mode },
    { opts.mappings.find,      desc = "Find Next",              mode = mode },
    { opts.mappings.find_left, desc = "Find Prev",              mode = mode },
    { opts.mappings.replace,   desc = "Replace/Subtitute",      mode = mode },
    { opts.mappings.highlight, desc = "Highlight Under Cursor", mode = mode },
  }
  return vim.list_extend(mappings, keys)
end
M.config = function(_, opts)
  require("mini.surround").setup(opts)
end
return M
