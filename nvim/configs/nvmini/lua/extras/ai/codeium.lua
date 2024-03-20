return {
  desc = "Free Alternative Code AI for Copilot. It is recommended to disable other AI Code Assist",

  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    lazy = true,
    opts = {
      bin_path = vim.fn.stdpath("cache") .. "/codeium/bin",
      config_path = vim.fn.stdpath("cache") .. "/codeium/config.json",
      language_server_download_url = "https://github.com",
      api = {
        host = "server.codeium.com",
        port = "443",
      },
    },
  },

  {
    "nvim-cmp",
    optional = true,
    dependencies = "Exafunction/codeium.nvim",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = 100,
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_y, 2, require("neoverse.utils").lualine.cmp_source("codeium"))
    end,
  },
}
