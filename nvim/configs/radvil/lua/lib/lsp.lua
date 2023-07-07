return {
  "jose-elias-alvarez/nvim-lsp-ts-utils",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "simrat39/inlay-hints.nvim",
  "williamboman/mason.nvim",
  "scalameta/nvim-metals",
  "b0o/schemastore.nvim",
  "j-hui/fidget.nvim",
  "folke/neodev.nvim",

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("rad.lsp")
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        auto_update = true,
        debounce_hours = 24,
        ensure_installed = {
          "black",
          "isort",
        },
      })
    end,
  },
}
