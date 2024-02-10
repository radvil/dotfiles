---@diagnostic disable: need-check-nil

return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
  },
  {
    "radvil/NeoLine",
    dev = true,
    ---@type NeoLineOpts
    opts = {
      modes = {
        ui = {
          n = {
            label = "Normal",
            bg = "#89b4fa",
          },
          c = {
            label = "Commando",
            bg = "#f5e0dc",
          },
        },
      },
    },
  },
  {
    "radvil2/windows.nvim",
    optional = true,
    opts = {
      animation = { enable = true },
    },
  },

  {
    "epwalsh/obsidian.nvim",
    optional = true,
    opts = {
      dir = vim.fn.expand("~") .. "/Documents/obsidian-vault",
    },
  },

  {
    "folke/persistence.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts) == "table" then
        opts.pre_save = function()
          require("neoverse.utils").info("saving session...", {
            title = "persistence",
            animate = false,
          })
        end
      end
    end,
  },

  {
    "stevearc/oil.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.keymaps) == "table" then
        local actions = require("oil.actions")
        -- new tab and close previous opened oil window
        local newtab = function()
          local bufnr = vim.api.nvim_get_current_buf()
          actions.select_tab.callback()
          vim.schedule(function()
            vim.api.nvim_buf_delete(bufnr, {})
          end)
        end
        opts.keymaps["<a-cr>"] = newtab
        opts.keymaps["<c-t>"] = newtab
      end
    end,
  },

  {
    "folke/which-key.nvim",
    optional = true,
    lazy = true,
  },

  {
    "rcarriga/nvim-notify",
    optional = true,
    opts = function(_, opts)
      opts.render = "wrapped-compact"
      opts.stages = "fade"
      if type(opts.banned_messages) == "table" then
        vim.list_extend(opts.banned_messages, { "No information available" })
      end
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    optional = true,
    ---@type NeoSnippetOpts
    opts = {
      json_snippets = {
        os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
        os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = {
      completion = { keyword_length = 1 },
      enabled = function()
        return vim.g.neo_autocomplete and vim.bo.buftype ~= "prompt"
      end,
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
    },
    init = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", {
        link = "Comment",
        default = true,
      })
    end,
  },

  {
    "folke/noice.nvim",
    optional = true,
    opts = {
      notify = { enabled = true },
      smartmove = { enabled = true },
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
      },
      popup_menu = {
        enabled = false,
      },
      views = {
        cmdline_popup = {
          position = {
            col = "50%",
            row = "20%",
          },
        },
        virtualtext = {
          hl_group = "FlashCurrent",
        },
      },
    },
  },
}
