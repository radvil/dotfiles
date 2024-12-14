return {
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = require("plugins.ui.opts.snacks-dashboard"),
    },
  },
}
