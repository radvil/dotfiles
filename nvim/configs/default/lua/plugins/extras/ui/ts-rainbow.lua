---@diagnostic disable: missing-fields
--- @type LazySpec
return {
  "HiPhish/nvim-ts-rainbow2",
  event = "BufReadPre",
  dependencies = "nvim-treesitter",
  config = function()
    local rainbow = require("ts-rainbow")
    require("nvim-treesitter.configs").setup({
      rainbow = {
        enable = true,
        strategy = rainbow.strategy.global,
        query = {
          "rainbow-parens",
          html = "rainbow-tags",
          latex = "rainbow-blocks",
        },
      },
    })
  end,
}
