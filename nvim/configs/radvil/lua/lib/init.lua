return {
  "tjdevries/express_line.nvim",
  "tjdevries/green_light.nvim",
  "tjdevries/colorbuddy.nvim",
  "tjdevries/overlength.vim",
  "tjdevries/gruvbuddy.nvim",
  "nvim-lua/plenary.nvim",
  "tjdevries/cyclist.vim",

  "norcalli/nvim-colorizer.lua",
  "mkitt/tabline.vim",
  "tpope/vim-repeat",

  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("statuscol").setup({
        setopt = true,
      })
    end,
  },
}
