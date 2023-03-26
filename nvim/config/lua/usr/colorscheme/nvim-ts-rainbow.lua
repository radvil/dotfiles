--- @type LazySpec
local M = {}
M[1] = "p00f/nvim-ts-rainbow"
M.event = "BufReadPre"
M.enabled = rvim.theme.rainbow_brackets
M.dependencies = "nvim-treesitter"
M.config = function()
  local colors = require("media.colors").palette
  require("nvim-treesitter.configs").setup({
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000,
      colors = {
        colors.red,
        colors.green,
        colors.blue,
        colors.yellow,
        colors.cyan,
        colors.magenta,
        colors.orange,
      },
    },
  })
end
return M
