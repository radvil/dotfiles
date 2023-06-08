---@type LazySpec
local M = {}
local util = require("utils")
M[1] = "nvim-telescope/telescope.nvim"
M.enabled = true
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
    desc = "telescope » find files",
    mode = "n",
  },
  {
    "<Leader>/d",
    ":Dotfiles<cr>",
    desc = "telescope » open nvim config",
  },
  {
    "<Leader>/f",
    "<Cmd>Telescope find_files<cr>",
    desc = "telescope » find files (root)",
  },
  { "<Leader>/w", util.telescope("live_grep"),                    desc = "telescope » live grep (cwd)" },
  { "<Leader>/W", util.telescope("live_grep", { cwd = false }),   desc = "telescope » live grep (root)" },
  { "<Leader>/S", util.telescope("grep_string"),                  desc = "telescope » grep Word (cwd)" },
  { "<Leader>/s", util.telescope("grep_string", { cwd = false }), desc = "telescope » grep Word (root)" },
  { "<Leader>//", "<cmd>Telescope resume<cr>",                    desc = "telescope » resume" },
  {
    "<Leader>/:",
    "<Cmd>Telescope command_history<Cr>",
    desc = "telescope » command history",
  },
  {
    "<Leader>/b",
    "<Cmd>Telescope buffers<Cr>",
    desc = "telescope » find opened buffers",
  },
  {
    "<Leader>/o",
    util.telescope("oldfiles", { cwd = vim.loop.cwd() }),
    desc = "telescope » find recent files (cwd)",
  },
  {
    "<Leader>/O",
    ":Telescope oldfiles<cr>",
    desc = "telescope » find recent files (root)",
  },
  {
    "<Leader>/h",
    "<Cmd>Telescope help_tags<Cr>",
    desc = "telescope » find help tags",
  },
  {
    "<f1>",
    ":Telescope help_tags<cr>",
    desc = "telescope » find help tags",
  },
  {
    "<Leader>/H",
    "<Cmd>Telescope highlights<Cr>",
    desc = "telescope » find highlights",
  },
  {
    "<Leader>/k",
    "<Cmd>Telescope keymaps<Cr>",
    desc = "telescope » find keymaps",
  },
  {
    "<Leader>/M",
    "<Cmd>Telescope man_pages<Cr>",
    desc = "telescope » find man pages",
  },
  {
    "<Leader>/C",
    util.telescope("colorscheme", { enable_preview = true }),
    desc = "telescope » find colorscheme",
  },
  {
    "<Leader>/c",
    "<Cmd>Telescope commands<Cr>",
    desc = "telescope » find available commands",
  },
  {
    "<Leader>/X",
    ":Telescope diagnostics<cr>",
    desc = "telescope » workspace diagnostics",
  },
  {
    "<Leader>/x",
    ":Telescope diagnostics bufnr=0<cr>",
    desc = "telescope » find diagnostics (cwd)",
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
      mappings = {
        ["i"] = {
          ["<A-Space>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-p>"] = actions.move_selection_previous,
          ["<A-j>"] = actions.cycle_history_next,
          ["<A-k>"] = actions.cycle_history_prev,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<C-u>"] = actions.preview_scrolling_up,
        },
        ["n"] = {
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
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
