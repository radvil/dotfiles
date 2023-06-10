---@desc better notifier
---@type LazySpec
local M = {}
M[1] = "rcarriga/nvim-notify"
M.event = "BufReadPost"
M.opts = function()
  local opts = {
    timeout = 1000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.36)
    end,
  }
  if rnv.opt.transbg then
    opts.background_colour = "#000000"
  end
  return opts
end
M.init = function()
  vim.notify = require("notify")
end
M.keys = {
  {
    "<c-z>n",
    function()
      require("notify").dismiss({
        silent = true,
        pending = true,
      })
    end,
    desc = "Toggle » Notification Prompt",
  },
}
return M
