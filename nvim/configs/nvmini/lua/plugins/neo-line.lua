return {
  "radvil/NeoLine",
  enabled = false,
  dependencies = "nvim-tree/nvim-web-devicons",
  dev = false,
  ---@type NeoLineOpts
  opts = {
    modes = {
      ui = {
        c = {
          name = "command",
          label = "Komandan",
          bg = "#f5e0dc",
        },
      },
    },
    specials = {
      ["lspinfo"] = function()
        local utils = require("neo-line.utils")
        local sections = require("neo-line.sections")
        vim.api.nvim_set_hl(0, "@lspinfo", {
          bg = "#89b4fa",
          fg = "#1e1e2e",
          bold = true,
        })
        vim.api.nvim_set_hl(0, "@lspinfo.separator", {
          link = "@neoline.mode.normal.inverted",
        })
        return table.concat({
          utils.hl("@lspinfo", "  LSP-INFO "),
          utils.hl("@lspinfo.separator", ""),
          utils.hl("Normal"),
          sections.separator(),
        })
      end,
    },
  },
}
