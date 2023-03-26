---@desc vscode like winbar
---@type LazySpec
local M = {}
M[1] = "utilyre/barbecue.nvim"
M.dependencies = {
  "nvim-tree/nvim-web-devicons",
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      depth_limit_indicator = "..",
      depth_limit = 9,
    },
  },
}
M.opts = {
  attach_navic = false,
  create_autocmd = false,
  modifiers = { dirname = ":s?.*??" },
  exclude_filetypes = require("opt.filetype").excludes,
  kinds = require("media.icons").KindIcons,
}
local attach_updater = function()
  --- @desc triggers CursorHold event faster
  vim.opt.updatetime = 200
  local events = {
    "BufWinEnter",
    "CursorHold",
    "InsertLeave",
    --- @desc include these if you have set `show_modified` to `true`
    "BufWritePost",
    "TextChanged",
    "TextChangedI",
  }
  vim.api.nvim_create_autocmd(events, {
    group = vim.api.nvim_create_augroup("BarbequeUpdater", { clear = true }),
    callback = function()
      require("barbecue.ui").update()
    end,
  })
end
M.init = function()
  attach_updater()
end
return M
