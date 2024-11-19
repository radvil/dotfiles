---@type LazySpec
return {
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  lazy = not string.match(vim.g.neo_colorscheme, "kanagawa"),
  opts = {
    -- theme = "wave", "wave" | "dragon" | "lotus"
    background = {
      --- @type "wave" | "dragon" | "lotus"
      dark = "wave",
      light = "lotus",
    },
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,
    dimInactive = false,
    terminalColors = true,
    colors = {
      palette = {},
      theme = {
        wave = {},
        lotus = {},
        dragon = {},
        all = {},
      },
    },
    ---@param _ table<string, string> colors
    ---@return table<string, string>
    overrides = function(_)
      return {}
    end,
  },
  config = function(_, opts)
    local transparent = vim.g.neo_transparent
    opts.transparent = transparent
    opts.dimInactive = not transparent
    require("kanagawa").setup(opts)
  end,
}
