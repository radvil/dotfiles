---@class NeoFlashFtExcludes
local ftMap = {
  popups = {
    "TelescopeResults",
    "TelescopePrompt",
    "DressingInput",
    "flash_prompt",
    "cmp_menu",
    "WhichKey",
    "incline",
    "prompt",
    "notify",
    "noice",
  },
  excludes = {
    "DiffviewFiles",
    "dashboard",
    "NvimTree",
    "neo-tree",
    "Outline",
    "prompt",
    "alpha",
    "help",
    "dbui",
    "dirbuf",
    "gitcommit",
    "Trouble",
    "help",
    "qf",
  },
  sidebars = {
    "NvimTree",
    "neo-tree",
    "Outline",
  },
}

local telescope_pick = function(prompt_bufnr)
  require("flash").jump({
    pattern = "^",
    label = { after = { 0, 0 } },
    search = {
      mode = "search",
      exclude = {
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
        end,
      },
    },
    action = function(match)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      picker:set_selection(match.pos[1] - 1)
    end,
  })
end

return {
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      defaults = {
        mappings = {
          ["n"] = { ["<a-m>"] = telescope_pick },
          ["i"] = { ["<a-m>"] = telescope_pick },
        },
      },
    },
  },

  ---@type LazySpec
  {
    "folke/flash.nvim",
    keys = function()
      return {
        {
          "<a-m>",
          mode = "n",
          function()
            require("flash").jump({
              search = {
                exclude = ftMap.popups,
                autojump = false,
                forward = true,
                wrap = true,
              },
            })
          end,
          desc = "ju[m]p anywhere",
        },
        {
          "<a-m>",
          mode = { "x", "o" },
          function()
            require("flash").jump({
              search = {
                multi_window = false,
                forward = true,
                wrap = true,
              },
            })
          end,
          desc = "ju[m]p anywhere",
        },
        {
          "<a-s>",
          mode = { "n", "v", "x", "o" },
          function()
            require("flash").treesitter({
              label = {
                rainbow = {
                  enabled = false,
                  shades = 3,
                },
              },
            })
          end,
          desc = "[s]elect node",
        },
        {
          "go",
          mode = "n",
          function()
            require("flash").jump({
              search = {
                exclude = ftMap.popups,
                multi_window = true,
                autojump = false,
                forward = true,
              },
              ---@param state Flash.State
              action = function(target, state)
                state:hide()
                vim.api.nvim_set_current_win(target.win)
                vim.api.nvim_win_set_cursor(target.win, target.pos)
                if vim.tbl_contains(ftMap.sidebars, vim.bo.filetype) then
                  vim.cmd.execute([["normal \<CR>"]])
                else
                  vim.cmd.execute([["normal gd"]])
                end
              end,
            })
          end,
          desc = "jump and [o]pen",
        },
        {
          "<leader>z",
          mode = "n",
          function()
            require("flash").jump({
              search = {
                exclude = ftMap.excludes,
                multi_window = true,
                autojump = false,
                forward = true,
              },
              ---@param state Flash.State
              action = function(target, state)
                state:hide()
                vim.api.nvim_set_current_win(target.win)
                vim.api.nvim_win_set_cursor(target.win, target.pos)
                vim.cmd.execute([["normal za"]])
                state:restore()
              end,
            })
          end,
          desc = "[z]ump + toggle fold",
        },
      }
    end,
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        mode = "exact",
        forward = true,
        multi_window = true,
        incremental = false,
      },
      jump = {
        jumplist = true,
        pos = "start", ---@type "start" | "end" | "range"
        history = false,
        register = false,
        nohlsearch = true,
        autojump = false,
        filetype_exclude = ftMap.excludes,
      },
      label = {
        current = true,
        after = false,
        before = true,
        reuse = "lowercase",
      },
      highlight = {
        backdrop = true,
        matches = true,
        groups = {
          match = "FlashMatch",
          current = "FlashCurrent",
          backdrop = "FlashBackdrop",
          label = "FlashLabel",
        },
      },
      modes = {
        search = { enabled = false },
        char = { enabled = false },
        treesitter = {
          labels = "abcdefghijklmnopqrstuvwxyz",
          jump = { pos = "range" },
          backdrop = false,
          matches = false,
          label = {
            before = true,
            after = true,
            style = "inline",
          },
          highlight = {
            backdrop = false,
            matches = false,
          },
        },
      },
    }, -- [EOL opts]
    config = function(_, opts)
      require("flash").setup(opts)
      vim.api.nvim_create_user_command("FlashToggleSearch", function()
        require("flash").toggle()
      end, { desc = "toggle flash.nvim search" })
    end,
  },
}
