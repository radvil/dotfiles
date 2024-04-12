return {
  -- disable gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    enabled = false,
  },

  {
    "echasnovski/mini.diff",
    event = "VeryLazy",
    keys = {
      {
        "<leader>go",
        function()
          -- TODO: notify current toggle status
          require("mini.diff").toggle_overlay(0)
        end,
        desc = "Toggle git [o]verlay",
      },
    },
    opts = {
      view = {
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "▎",
        },
      },
    },
  },

  -- lualine integration
  {
    "lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local y = opts.sections.lualine_y
      for _, comp in ipairs(y) do
        if comp[1] == "diff" then
          comp.source = function()
            local summary = vim.b.minidiff_summary
            return summary
              and {
                added = summary.add,
                modified = summary.change,
                removed = summary.delete,
              }
          end
          break
        end
      end
    end,
  },
}
