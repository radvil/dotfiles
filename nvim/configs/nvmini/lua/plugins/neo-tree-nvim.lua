return {
  "nvim-neo-tree/neo-tree.nvim",
  optional = true,
  opts = {
    window = {
      position = "right",
      width = 42,
    },
    source_selector = {
      winbar = true,
      statusline = false,
      truncation_character = "…",
      sources = {
        {
          source = "filesystem",
          display_name = " 󰙅 files",
        },
        {
          source = "buffers",
          display_name = "  buffers",
        },
        {
          source = "git_status",
          display_name = "  git",
        },
      },
    },
  },
}
