---@diagnostic disable: need-check-nil

return {
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
    "mrjones2014/legendary.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.extensions) == "table" then
        if not require("neoverse.utils").lazy_has("which-key.nvim") then
          opts.extensions.which_key = false
        end
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
