return {
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    keys = {
      {
        "<leader>up",
        function()
          if not require("nvim-autopairs").state.disabled then
            require("nvim-autopairs").disable()
            LazyVim.warn("Disabled auto pairs", { title = "Option" })
          else
            require("nvim-autopairs").enable()
            LazyVim.info("Enabled auto pairs", { title = "Option" })
          end
        end,
        desc = "toggle auto[p]airs",
      },
    },
    init = function()
      if not vim.g.neo_autopairs then
        require("nvim-autopairs").disable()
      end
    end,
  },
}
