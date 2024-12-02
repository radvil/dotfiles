local disabled_plugins = {
  -- "folke/which-key.nvim",
  -- "echasnovski/mini.indentscope",
  "folke/noice.nvim",
  "echasnovski/mini.ai",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "MagicDuck/grug-far.nvim",
  -- "stevearc/dressing.nvim",
}

---@type LazySpec[]
local M = {}

for index, value in ipairs(disabled_plugins) do
  M[index] = { value, enabled = false }
end

return M
