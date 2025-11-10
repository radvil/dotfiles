return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
  },
  {
    "nvim-mini/mini.statusline",
    opts = {
      set_vim_settings = true,
      use_icons = true,
      content = {
        inactive = nil,
        active = nil,
      },
    },
  },
}
