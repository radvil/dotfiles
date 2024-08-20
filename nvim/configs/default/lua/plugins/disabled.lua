local disabled_plugins = {
  -- "folke/which-key.nvim",
  -- "folke/noice.nvim",
  -- "echasnovski/mini.indentscope",
  "echasnovski/mini.ai",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "MagicDuck/grug-far.nvim",
}

---@type LazySpec[]
local M = {}

for index, value in ipairs(disabled_plugins) do
  M[index] = { value, enabled = false }
end

return M
