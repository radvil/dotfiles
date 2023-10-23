return {
  "folke/persistence.nvim",
  opts = {
    options = {
      "buffers",
      "tabpages",
      "winsize",
      "curdir",
      "help",
    },
  },
  -- stylua: ignore start
  keys = function()
    return {
      {
        "<Leader>Sr",
        function() require("persistence").load() end,
        desc = "Session » Restore (cwd)",
      },
      {
        "<Leader>Sl",
        function() require("persistence").load({ last = true }) end,
        desc = "Session » Restore last",
      },
      {
        "<Leader>Ss",
        function() require("persistence").stop() end,
        desc = "Session » Stop saving",
      },
    }
  end,
}
