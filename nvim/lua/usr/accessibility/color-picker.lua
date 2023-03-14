---@desc floating color picker
---@type LazySpec
local M = {}

M[1] = "ziontee113/color-picker.nvim"

M.cmd = {
  "PickColor",
  "PickColorInsert",
}

local noremap = {
  noremap = true,
  silent = true,
}

M.keys = {
  {
    "<A-c>",
    "<CMD>PickColor<CR>",
    desc = "Pick color",
    unpack(noremap),
  },
  {
    "<A-c>",
    "<CMD>PickColorInsert<CR>",
    desc = "Pick color insert",
    unpack(noremap),
    mode = "i",
  },
}

M.config = function()
  require("color-picker").setup()
end

return M
