---@type LazySpec
local M = {}
M[1] = "jackMort/ChatGPT.nvim"
M.event = "VeryLazy"
M.config = function()
  require("chatgpt").setup()
end
M.dependencies = {
  "MunifTanjim/nui.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim"
}
return M
