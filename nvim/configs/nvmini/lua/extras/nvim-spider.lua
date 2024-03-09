return {
  "chrisgrieser/nvim-spider",
  opts = {
    skipInsignificantPunctuation = false,
  },
  keys = {
    { mode = "n", "w", "<cmd>lua require('spider').motion('w')<CR>", desc = "Spider-w" },
    { mode = "n", "e", "<cmd>lua require('spider').motion('e')<CR>", desc = "Spider-e" },
    { mode = "n", "b", "<cmd>lua require('spider').motion('b')<CR>", desc = "Spider-b" },
    { mode = "n", "ge", "<cmd>lua require('spider').motion('ge')<CR>", desc = "Spider-ge" },
    { mode = "o", "w", "<cmd>lua require('spider').motion('w')<CR>", desc = "Spider-w" },
    { mode = "o", "e", "<cmd>lua require('spider').motion('e')<CR>", desc = "Spider-e" },
    { mode = "o", "b", "<cmd>lua require('spider').motion('b')<CR>", desc = "Spider-b" },
    { mode = "o", "ge", "<cmd>lua require('spider').motion('ge')<CR>", desc = "Spider-ge" },
    { mode = "x", "w", "<cmd>lua require('spider').motion('w')<CR>", desc = "Spider-w" },
    { mode = "x", "e", "<cmd>lua require('spider').motion('e')<CR>", desc = "Spider-e" },
    { mode = "x", "b", "<cmd>lua require('spider').motion('b')<CR>", desc = "Spider-b" },
    { mode = "x", "ge", "<cmd>lua require('spider').motion('ge')<CR>", desc = "Spider-ge" },
  },
}
