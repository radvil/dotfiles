local palette = require("neoverse.config").palette

return {
  "catppuccin",
  optional = true,
  ---@type CatppuccinOptions
  opts = {
    flavour = "mocha",
    background = {
      light = "latte",
      dark = "mocha",
    },
    dim_inactive = {
      enabled = false,
      percentage = 0.13,
      shade = "dark",
    },
    color_overrides = {
      mocha = {
        surface0 = palette.dark2,
      },
    },
    integrations = {
      alpha = false,
      barbar = false,
      barbecue = {
        dim_dirname = false,
        bold_basename = false,
        dim_context = false,
        alt_background = false,
      },
      dap = false,
      dropbar = false,
      flash = false,
      mini = false,
      noice = false,
      notify = false,
    },
  },
}
