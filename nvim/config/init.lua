require("core").bootstrap({
  -- register global variable(s) and api(s)
  settings = require("core").setup(),

  -- load all plugins's specs
  on_init = function(options)
    rnv.api.log("ON INIT", "init")
    require("opt.options")
    require("lazy").setup({
      "folke/lazy.nvim",
      require("libs.color"),
      require("libs.lsp"),
      require("libs.misc"),
      require("usr.accessibility"),
      require("usr.completion"),
      require("usr._preview"),
      require("usr.ui"),
    }, options)
  end,

  -- load these after all plugins
  after_init = function()
    rnv.api.log("AFTER INIT", "init")
    require("opt.autocmds")
    require("opt.keymaps")
  end,
})
