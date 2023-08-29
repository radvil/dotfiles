return {
  "radvil2/windows.nvim",
  dependencies = "anuvyklack/middleclass",
  event = "VeryLazy",

  keys = {
    {
      "<Leader>wm",
      ":WindowsMaximize<cr>",
      desc = "Window » Maximize/minimize",
    },
    {
      "<Leader>w=",
      ":WindowsEqualize<cr>",
      desc = "Window » Equalize",
    },
    {
      "<Leader>wu",
      ":WindowsToggleAutowidth<cr>",
      desc = "Window » Toggle autowidth",
    },
  },

  config = function()
    require("windows").setup({
      animation = { enable = false },
      autowidth = {
        enable = false,
        winwidth = 5,
        filetype = {
          help = 2,
        },
      },
      ignore = {
        buftype = { "nofile", "quickfix", "edgy" },
        filetype = {
          unpack(require("minimal.filetype").Popups),
          "help",
        },
      },
    })
  end,
}
