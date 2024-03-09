---@diagnostic disable: duplicate-set-field

return {
  "stevearc/dressing.nvim",
  lazy = true,
  init = function()
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.select(...)
    end
    vim.ui.input = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.input(...)
    end
  end,
  config = function(_, opts)
    local Prefer = require("preferences")
    opts = vim.tbl_deep_extend("force", {
      input = {
        relative = "editor",
        border = "single",
        win_options = { winblend = Prefer.transparent and 0 or 10 },
        mappings = {
          i = { ["<a-space>"] = "Close" },
        },
      },
    }, opts or {}) or {}
    require("dressing").setup(opts)
  end,
}
