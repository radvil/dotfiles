---@type LazySpec
return {
  "abecodes/tabout.nvim",
  event = "InsertEnter",
  dependencies = { "nvim-cmp", "nvim-treesitter" },
  opts = {
    tabkey = "<a-l>",
    backwards_tabkey = "<a-h>",
  },
}
