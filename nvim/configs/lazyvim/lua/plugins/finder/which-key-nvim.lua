return {
  "folke/which-key.nvim",
  opts = {
    defaults = {
      mode = { "n" },
      ["g"] = { name = "+Goto" },
      ["s"] = { name = "+Surround" },
      ["]"] = { name = "+Next" },
      ["["] = { name = "+Prev" },
      ["<leader>b"] = { name = "+Buffer" },
      ["<leader>q"] = { name = "+Quick Commands" },
      ["<leader>c"] = { name = "+Code" },
      ["<leader>f"] = { name = "+Finder" },
      ["<leader>g"] = { name = "+Git" },
      ["<leader>u"] = { name = "+Toggle" },
      ["<leader>w"] = { name = "+Windows" },
      ["<leader>x"] = { name = "+Diagnostics/quickfix" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
