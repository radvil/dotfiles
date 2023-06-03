---@type LazySpec
local M = {}
M[1] = "radvil/fokus.nvim"
M.enabled = false
M.event = "BufReadPre"
M.dependencies = { "folke/twilight.nvim", "folke/zen-mode.nvim" }
---@type FokusOptions
M.keys = {
  {
    "<Leader>wf",
    "<Cmd>ZenMode<Cr>",
    desc = "fokus-nvim » toggle zen mode",
  },
}
M.opts = {
  view = {
    notify_status_change = false,
    blacklists_filetypes = require("opt.filetype").excludes,
    on_fokus_leave = nil,
    on_fokus_enter = nil
  },
}
return M
