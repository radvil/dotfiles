---@desc active indent guide and indent text objects
---@type LazySpec
local M = {}
M[1] = "echasnovski/mini.indentscope"
M.enabled = true
M.event = "BufReadPre"
M.opts = {
  symbol = "│",
  mappings = {
    object_scope = 'ii',
    object_scope_with_border = 'ai',
    goto_top = '[i',
    goto_bottom = ']i',
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
