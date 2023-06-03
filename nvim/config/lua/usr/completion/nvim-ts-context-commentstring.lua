---@type LazySpec
local M = {}
M[1] = "JoosepAlviste/nvim-ts-context-commentstring"
M.event = "VeryLazy"
M.dependencies = { "nvim-treesitter/nvim-treesitter" }
M.opts = {
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      json = {
        __multiline = "/* %s */",
        __default = "// %s",
      },
    },
  },
}
M.config = function(_, opts)
  require("nvim-treesitter.configs").setup(opts)
end
return M
