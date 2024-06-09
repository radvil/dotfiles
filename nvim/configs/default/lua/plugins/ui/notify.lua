---@diagnostic disable: missing-fields, duplicate-set-field
return {
  {
    "telescope.nvim",
    optional = true,
    dependencies = { "rcarriga/nvim-notify" },
  },

  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "ZN",
        function()
          require("notify").dismiss({ pending = true, silent = true })
        end,
        desc = "quit/dismiss [N]otifications",
      },
      {
        "<leader>/N",
        function()
          require("telescope").extensions.notify.notify()
        end,
        desc = "View all [N]otifications",
      },
    },
    ---@type notify.Config
    opts = {
      ---@type "default" | "minimal" | "simple" | "compact" | "wrapped-compact"
      render = "default",
      ---@type "fade_in_slide_out" | "fade" | "slide" | "static"
      stages = "static",
      timeout = 1000,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
    },
    init = function()
      LazyVim.on_very_lazy(function()
        vim.notify = require("notify")
      end)
    end,
  },
}
