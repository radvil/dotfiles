return {
  "nvim-mini/mini.splitjoin",
  keys = {
    {
      "<leader>uj",
      function()
        require("mini.splitjoin").toggle()
      end,
      desc = "split/[j]oin",
    },
  },
  opts = {
    mappings = {
      toggle = "",
      split = "",
      join = "",
    },
  },
}
