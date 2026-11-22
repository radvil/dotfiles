local disabled_plugins = {
  -- "nvim-mini/mini.indentscope",
  -- "folke/noice.nvim",
  -- "folke/which-key.nvim",
  "nvim-mini/mini.ai",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/nvim-treesitter-context",
  "MagicDuck/grug-far.nvim",
  "stevearc/dressing.nvim",
  "nvim-telescope/telescope.nvim",
}

---@type LazySpec[]
local M = {}

for index, value in ipairs(disabled_plugins) do
  M[index] = { value, enabled = false }
end

return M
