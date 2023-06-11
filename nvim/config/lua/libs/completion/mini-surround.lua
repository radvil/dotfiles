---@type LazySpec
local M = {}
M[1] = "echasnovski/mini.surround"
M.opts = {
  mappings = {
    add = "so",
    delete = "sd",
    find_left = "s[",
    find = "s]",
    highlight = "sh",
    replace = "ss",
    update_n_lines = "",
  },
}

-- ---@diagnostic disable-next-line: assign-type-mismatch
-- M.keys = function(plugin, keys)
--   local opts = require("lazy.core.plugin").values(plugin, "opts", false)
--   local mode = { "n", "x" }
--   local mappings = {
--     { opts.mappings.add,       desc = "Surround » open/add",          mode = mode },
--     { opts.mappings.delete,    desc = "Surround » delete",            mode = mode },
--     { opts.mappings.find,      desc = "Surround » find next",         mode = mode },
--     { opts.mappings.find_left, desc = "Surround » find prev",         mode = mode },
--     { opts.mappings.replace,   desc = "Surround » replace/subtitute", mode = mode },
--     { opts.mappings.highlight, desc = "Surround » highlight current", mode = mode },
--   }
--   return vim.list_extend(mappings, keys)
-- end

M.config = function(_, opts)
  require("mini.surround").setup(opts)
end

return M
