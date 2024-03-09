return {
  "b0o/incline.nvim",
  event = "BufWinEnter",
  opts = {
    render = "basic",
    ignore = {
      buftypes = "special",
      filetypes = {},
      floating_wins = true,
      unlisted_buffers = true,
      wintypes = "special",
    },
    window = {
      width = "fit",
      padding = 1,
      winhighlight = {
        inactive = { Normal = "InclineInActive" },
        active = { Normal = "InclineActive" },
      },
      margin = {
        vertical = 0,
        horizontal = 0,
      },
      placement = {
        horizontal = "right",
        vertical = "bottom",
      },
    },
  },
}
