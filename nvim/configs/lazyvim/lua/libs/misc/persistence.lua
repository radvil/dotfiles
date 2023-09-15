---@type LazySpec
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    options = {
      "buffers",
      "tabpages",
      "winsize",
      "skiprtp",
      "globals",
      "curdir",
      "help",
    },
  },

  -- override LazyVim config
  keys = function()
    return {
      {
        "<Leader>Sr",
        function()
          require("persistence").load()
        end,
        desc = "Session » Restore (cwd)",
      },
      {
        "<Leader>Sl",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Session » Restore last",
      },
      {
        "<Leader>Ss",
        function()
          require("persistence").stop()
        end,
        desc = "Session » Stop saving",
      },
    }
  end,
}
