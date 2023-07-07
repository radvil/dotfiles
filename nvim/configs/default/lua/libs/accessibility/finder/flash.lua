---@type LazySpec
local M = {}

M[1] = "folke/flash.nvim"
M.event = "VeryLazy"
M.enabled = function()
  return rnv.opt.dev
end
M.keys = {
  {
    "<a-m>",
    mode = { "n", "x", "o" },
    --stylua: ignore
    function() require("flash").jump() end,
  },
  {
    "<a-s>",
    mode = { "n", "x", "v" },
    --stylua: ignore
    function() require("flash").treesitter() end,
  },
  {
    "<a-s>",
    function()
      local curr_win = vim.api.nvim_get_current_win()
      local curr_view = vim.fn.winsaveview()
      require("flash").jump({
        action = function(target, state)
          state:hide()
          vim.api.nvim_set_current_win(target.win)
          vim.api.nvim_win_set_cursor(target.win, target.pos)
          require("flash").treesitter()
          vim.schedule(function()
            vim.api.nvim_set_current_win(curr_win)
            vim.fn.winrestview(curr_view)
          end)
        end,
      })
    end,
    mode = "o",
    desc = "Treesitter » select node",
  },
}

M.opts = {
  labels = "asdfghjklqwertyuiopzxcvbnm",
  search = {
    mode = "exact",
    forward = true,
    multi_window = true,
    incremental = false,
    --stylua: ignore
    filetype_exclude = vim.list_extend(
      vim.deepcopy(require("opt.filetype").popups),
      require("opt.filetype").sidebars
    ),
  },
  jump = {
    jumplist = true,
    pos = "start", ---@type "start" | "end" | "range"
    history = false,
    register = false,
    nohlsearch = true,
    autojump = true,
    --stylua: ignore
    filetype_exclude = vim.list_extend(
      vim.deepcopy(require("opt.filetype").popups),
      require("opt.filetype").sidebars
    ),
  },
  highlight = {
    backdrop = true,
    matches = true,
    label = {
      current = true,
      after = true,
      before = false,
      reuse = "lowercase",
    },
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
      highlight = {
        backdrop = false,
        matches = false,
        label = {
          before = true,
          after = true,
          style = "inline",
        },
      },
    },
  },
}

return M
