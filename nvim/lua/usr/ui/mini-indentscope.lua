---@desc active indent guide and indent text objects
---@type LazySpec
local M = {}
M[1] = "echasnovski/mini.indentscope"
M.event = "BufReadPre"
M.opts = {
  symbol = "│",
  options = {
    try_as_border = true,
  },
}
M.config = function(_, opts)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = require("opt.filetype").excludes,
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
  require("mini.indentscope").setup(opts)
end
return M
