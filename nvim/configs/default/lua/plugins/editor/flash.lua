---@diagnostic disable: missing-fields
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

---jump to definition with flash
---@param jump_type "vsplit" | "split" | "tab drop" | nil
local jump_to_definition = function(jump_type)
  return function()
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
        require("telescope.builtin").lsp_definitions({ jump_type = jump_type })
      end,
    })
  end
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

  {
    "neovim/nvim-lspconfig",
    optinal = true,
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(Keys, {
        {
          "<a-g><a-d>",
          jump_to_definition(),
          desc = "Jump to Definition",
          has = "definition",
        },
        {
          "<a-g><a-v>",
          jump_to_definition("vsplit"),
          desc = "Jump to Definition (vsplit)",
          has = "definition",
        },
        {
          "<a-g><a-x>",
          jump_to_definition("split"),
          desc = "Jump to Definition (split)",
          has = "definition",
        },
        {
          "<a-g><a-t>",
          jump_to_definition("tab drop"),
          desc = "Jump to Definition (tab drop)",
          has = "definition",
        },
      })
    end,
  },

  ---@type LazySpec
  {
    "folke/flash.nvim",
    keys = function()
      return {
        {
          "<a-m>",
          mode = { "n", "i" },
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
                  vim.api.nvim_input("<cr>")
                else
                  vim.api.nvim_input("gd")
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
                vim.api.nvim_input("za")
                vim.schedule(function()
                  state:restore()
                end)
              end,
            })
          end,
          desc = "[z]ump + toggle fold",
        },
      }
    end,
    opts = {
      -- labels = "asdfghjklqwertyuiopzxcvbnm",
      -- NOTE: exclude j and k for better escape support
      labels = "asdfghlqwertyuiopzxcvbnm",
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
