---@desc easy motion to comments
---@type LazySpec
local M = {}
M[1] = "echasnovski/mini.comment"
M.enabled = false
M.event = "VeryLazy"
M.opts = {
  hooks = {
    pre = function()
      require("ts_context_commentstring.internal").update_commentstring({})
    end,
  },
}
M.dependencies = {
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
}
M.config = function(_, opts)
  require("mini.comment").setup(opts)
end
return M
