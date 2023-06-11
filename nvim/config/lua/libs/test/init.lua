---@type LazySpec[]
if not rnv.opt.dev then
  return {}
end

---@type LazySpec[]
return {
  -- prevent neo-tree from opening files in edgy windows
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
    },
  },

  ---@type LazySpec
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      wo = {
        winbar = false,
      },
      options = {
        left = { size = 33 },
      },
      animate = {
        enabled = true,
        fps = 100,
        cps = 120,
        on_begin = function()
          vim.g.minianimate_disable = true
        end,
        on_end = function()
          vim.g.minianimate_disable = false
        end,
        spinner = {
          frames = require("opt.icons").SpinnerFramesAlt,
          interval = 80,
        },
      },
      bottom = {
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        "Trouble",
        {
          ft = "qf",
          title = "QuickFix"
        },
        {
          ft = "help",
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
        { ft = "spectre_panel", size = { height = 0.4 } },
      },
      left = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = "WORKDIR",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          size = { height = 0.5 },
        },
        {
          title = "BUFFERS",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          open = "Neotree position=top buffers",
        },
        -- any other neo-tree windows
        "neo-tree",
      },
    },
  }
}
