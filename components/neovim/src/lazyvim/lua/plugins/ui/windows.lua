local M = {
  "radvil2/windows.nvim",
  lazy = true,
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
}

M.keys = {
  {
    "<Leader>wm",
    "<Cmd>WindowsMaximize<cr>",
    desc = "[m]aximize/[m]inimize [w]indow",
  },
  {
    "<Leader>w=",
    "<Cmd>WindowsEqualize<cr>",
    desc = "[=]qualize windows",
  },
  {
    "<Leader>wu",
    "<Cmd>WindowsToggleAutowidth<cr>",
    desc = "toggle [w]indow autowidth",
  },
}

M.opts = {
  animation = { enable = true },
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
      "TelescopeResults",
      "TelescopePrompt",
      "neo-tree-popup",
      "DressingInput",
      "flash_prompt",
      "cmp_menu",
      "neo-tree",
      "NvimTree",
      "WhichKey",
      "Outline",
      "prompt",
      "lspinfo",
      "notify",
      "mason",
      "noice",
      "noice",
      "lazy",
      "help",
      "oil",
    },
  },
}

M.config = function(_, opts)
  vim.o.winwidth = 10
  vim.o.winminwidth = 10
  vim.o.equalalways = false
  if vim.g.neovide then
    opts.animation.enable = false
  end
  require("windows").setup(opts)
end

return M
