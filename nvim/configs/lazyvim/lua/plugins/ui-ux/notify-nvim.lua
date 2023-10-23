---@type LazySpec
local M = {
  "rcarriga/nvim-notify",
  event = "BufReadPost",

  config = function(_, opts)
    ---@type notify.Config
    opts = vim.tbl_deep_extend("force", opts or {}, {
      background_colour = "NotifyBackground",
      render = "default",
      timeout = 1000,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.36)
      end,
    })

    if require("preferences").transparent then
      opts.background_colour = "#000000"
    end

    require("notify").setup(opts)
  end,

  init = function()
    local Util = require("lazyvim.util")
    if Util.has("noice.nvim") then
      Util.on_very_lazy(function()
        vim.notify = require("notify")
      end)
    else
      vim.keymap.set("n", "<leader>nd", function()
        require("notify").dismiss({
          pending = true,
          silent = true,
        })
      end, { desc = "Notification » Dismiss" })
    end
  end,
}

return M
