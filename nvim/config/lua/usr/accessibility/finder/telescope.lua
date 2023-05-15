---@desc fuzzy finder
---@type LazySpec
local M = {}

local util = require("utils")

M[1] = "nvim-telescope/telescope.nvim"

M.cmd = "Telescope"

M.dependencies = {
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make",
  config = function()
    require("telescope").load_extension("fzf")
  end,
}

M.keys = {
  {
    "<C-p>",
    util.telescope("files"),
    "<Cmd>Telescope find_files<Cr>",
    desc = "Find » Files [CWD]",
    mode = "n",
  },
  {
    "<Leader>/f",
    "<Cmd>Telescope find_files<Cr>",
    desc = "Find » Files",
  },
  {
    "<Leader>/w",
    "<Cmd>Telescope live_grep<Cr>",
    desc = "Find » Word",
  },
  {
    "<Leader>/:",
    "<Cmd>Telescope command_history<Cr>",
    desc = "Find » Commands History",
  },
  {
    "<Leader>/b",
    "<Cmd>Telescope buffers<Cr>",
    desc = "Find » Opened Buffers",
  },
  {
    "<Leader>/o",
    "<Cmd>Telescope oldfiles<Cr>",
    desc = "Find » Last Files",
  },
  {
    "<Leader>/h",
    "<Cmd>Telescope help_tags<Cr>",
    desc = "Find » Help Tags",
  },
  {
    "<Leader>/H",
    "<Cmd>Telescope highlights<Cr>",
    desc = "Find » Highlight Groups",
  },
  {
    "<Leader>/k",
    "<Cmd>Telescope keymaps<Cr>",
    desc = "Find » Register Keymaps",
  },
  {
    "<Leader>/M",
    "<Cmd>Telescope man_pages<Cr>",
    desc = "Find » Manual Pages",
  },
  {
    "<Leader>/c",
    util.telescope("colorscheme", { enable_preview = true }),
    desc = "Find » Colorschemes",
  },
  {
    "<Leader>/C",
    "<Cmd>Telescope commands<Cr>",
    desc = "Find » User Commands",
  },
}

M.opts = function()
  local actions = require("telescope.actions")
  return {
    defaults = {
      layout_config = { prompt_position = "top" },
      layout_strategy = "horizontal",
      sorting_strategy = "ascending",
      prompt_prefix = " 🔭 ",
      -- winblend = 0,
      mappings = {
        ["i"] = {
          ["<A-Space>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<C-u>"] = actions.preview_scrolling_up,
        },
        ["n"] = {
          ["q"] = actions.close,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.move_selection_next,
          ["sh"] = actions.select_horizontal,
          ["sv"] = actions.select_vertical,
        },
      },
    },
  }
end

function M.init()
  vim.api.nvim_create_user_command("Dotfiles", function()
    require("utils").telescope("files", {
      cwd = rvim.path.config,
    })()
  end, {})
end

return M
