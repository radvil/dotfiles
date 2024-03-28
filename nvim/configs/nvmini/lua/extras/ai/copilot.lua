local activated = false

return {
  {
    "lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_y, 2, Lonard.lualine.cmp_source("copilot"))
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    keys = {
      {
        "<leader>ug",
        function()
          if activated then
            vim.cmd("Copilot disable")
            Lonard.warn("server disabled", { title = "Copilot" })
          else
            vim.cmd("Copilot enable")
            Lonard.info("server enabled", { title = "Copilot" })
          end
          activated = not activated
        end,
        desc = "Toggle » Github Copilot",
      },
    },
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      if not activated then
        -- vim.schedule(function()
          vim.cmd("Copilot disable")
        -- end)
      end
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    config = function()
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup({ fix_pairs = true })
      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      Lonard.lsp.on_attach(function(client)
        if client.name == "copilot" and activated then
          copilot_cmp._on_insert_enter({})
        end
      end)
    end,
  },

  {
    "nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 1,
        priority = 100,
      })
    end,
  },
}
