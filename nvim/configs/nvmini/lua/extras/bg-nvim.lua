-- Automatically syncs terminal background and cursor
-- with any neovim colorscheme.
return {
  "typicode/bg.nvim",
  lazy = false,
  enabled = function()
    return not vim.g.neo_transparent
  end
}
