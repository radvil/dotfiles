return {
  "hedyhli/outline.nvim",
  cmd = "Outline",
  keys = function()
    return {
      {
        "<leader>cs",
        "<cmd>Outline<cr>",
        desc = "toggle [c]ode [s]ymbols",
      },
    }
  end,
  config = function()
    local defaults = require("outline.config").defaults
    local filter = LazyVim.config.kind_filter
    local opts = {
      symbols = {
        filter = filter,
        icons = {},
      },
      outline_window = {
        winhl = "Normal:NormalFloat",
      },
    }
    if type(filter) == "table" then
      for kind, symbol in pairs(defaults.symbols.icons) do
        opts.symbols.icons[kind] = {
          icon = LazyVim.config.icons.kinds[kind] or symbol.icon,
          hl = symbol.hl,
        }
      end
    end
    require("outline").setup(opts)
  end,
}
