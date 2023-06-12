---@type LazySpec
local M = {}
local util = require("common.utils")
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
    "<c-p>",
    util.telescope("files"),
    ":Telescope find_files<cr>",
    desc = "telescope » find files",
    mode = "n",
  },
  {
    "<leader>/.",
    ":Dotfiles<cr>",
    desc = "telescope » find dotfiles",
  },
  {
    "<leader>/f",
    ":Telescope find_files<cr>",
    desc = "telescope » find files (root)",
  },
  { "<leader>/w", util.telescope("live_grep"),                    desc = "telescope » live grep (cwd)" },
  { "<leader>/W", util.telescope("live_grep", { cwd = false }),   desc = "telescope » live grep (root)" },
  { "<leader>/S", util.telescope("grep_string"),                  desc = "telescope » grep word (cwd)" },
  { "<leader>/s", util.telescope("grep_string", { cwd = false }), desc = "telescope » grep word (root)" },
  {
    "<leader>//",
    ":Telescope resume<cr>",
    desc = "telescope » resume"
  },
  {
    "<leader>/:",
    ":Telescope command_history<cr>",
    desc = "telescope » command history",
  },
  {
    "<leader>/b",
    ":Telescope buffers<cr>",
    desc = "telescope » find opened buffers",
  },
  {
    "<leader>/o",
    util.telescope("oldfiles", { cwd = vim.loop.cwd() }),
    desc = "telescope » find recent files (cwd)",
  },
  {
    "<leader>/O",
    ":Telescope oldfiles<cr>",
    desc = "telescope » find recent files (root)",
  },
  {
    "<leader>/h",
    ":Telescope help_tags<Cr>",
    desc = "telescope » find help tags",
  },
  {
    "<f1>",
    ":Telescope help_tags<cr>",
    desc = "telescope » find help tags",
  },
  {
    "<leader>/H",
    ":Telescope highlights<cr>",
    desc = "telescope » find highlights",
  },
  {
    "<leader>/k",
    ":Telescope keymaps<cr>",
    desc = "telescope » find keymaps",
  },
  {
    "<leader>/M",
    ":Telescope man_pages<cr>",
    desc = "telescope » find man pages",
  },
  {
    "<leader>/C",
    util.telescope("colorscheme", { enable_preview = true }),
    desc = "telescope » find colorscheme",
  },
  {
    "<leader>/c",
    ":Telescope commands<cr>",
    desc = "telescope » find available commands",
  },
  {
    "<leader>/X",
    ":Telescope diagnostics<cr>",
    desc = "telescope » workspace diagnostics",
  },
  {
    "<leader>/x",
    ":Telescope diagnostics bufnr=0<cr>",
    desc = "telescope » find diagnostics (cwd)",
  },
  {
    "<leader>/g",
    ":Telescope git_branches<cr>",
    desc = "telescope » git branches",
  },
  {
    "<leader>/j",
    util.telescope("jumplist", { initial_mode = "normal" }),
    desc = "telescope » jump list",
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
          ["<a-space>"] = actions.close,
          ["<cr>"] = actions.select_default,
          ["<c-h>"] = actions.select_horizontal,
          ["<c-v>"] = actions.select_vertical,
          ["<c-p>"] = actions.move_selection_previous,
          ["<a-j>"] = actions.cycle_history_next,
          ["<a-k>"] = actions.cycle_history_prev,
          ["<c-n>"] = actions.move_selection_next,
          ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble,
          ["<c-d>"] = actions.preview_scrolling_down,
          ["<c-u>"] = actions.preview_scrolling_up,
        },
        ["n"] = {
          ["<esc>"] = actions.close,
          ["<c-p>"] = actions.move_selection_previous,
          ["<c-n>"] = actions.move_selection_next,
          ["<c-h>"] = actions.select_horizontal,
          ["<c-v>"] = actions.select_vertical,
        },
      },
    },
  }
end

function M.init()
  vim.api.nvim_create_user_command("Dotfiles", function()
    require("utils").telescope("files", {
      prompt_title = '🔧 DOTFILES',
      cwd = os.getenv("DOTFILES"),
    })()
  end, {})
end

return M
