return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
  },
  {
    "echasnovski/mini.statusline",
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
