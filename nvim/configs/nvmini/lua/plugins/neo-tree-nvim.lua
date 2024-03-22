return {
  "nvim-neo-tree/neo-tree.nvim",
  optional = true,
  opts = {
    window = {
      position = "left",
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
    filesystem = {
      window = {
        mappings = {
          ["O"] = {
            function(state)
              local fpath = state.tree:get_node().path
              Lonard.open_with_system_default(fpath)
            end,
            desc = "open with system default",
          },
        }
      }
    }
  },
}
