---@desc search/replace in multiple files
---@type LazySpec
local M = {}

M[1] = "windwp/nvim-spectre"

M.enabled = true

M.keys = {
  {
    "<Leader>sr",
    function()
      require("spectre").open()
    end,
    desc = "[spectre] replace words in files",
  },
}

return M
