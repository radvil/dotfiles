return {
  {
    "stevearc/oil.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    deactivate = function()
      vim.cmd([[Oil close]])
    end,
    -- stylua: ignore
      keys = {
          {
              "<Leader>fe",
              function() require("oil").toggle_float() end,
              desc = "Float » Explorer (pwd)",
          },
      },
  }
}
