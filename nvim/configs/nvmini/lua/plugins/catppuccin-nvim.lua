local palette = require("neoverse.config").palette

return {
  "catppuccin",
  optional = true,
  opts = function()
    ---@type CatppuccinOptions
    return {
      flavour = "auto",
      background = {
        dark = "frappe",
        light = "latte",
      },
      dim_inactive = {
        enabled = false,
        percentage = 0.13,
        shade = "dark",
      },
      color_overrides = {
        mocha = { surface0 = palette.dark2 },
        frappe = {
          red = "#ff657a",
          maroon = "#F29BA7",
          peach = "#ff9b5e",
          yellow = "#eccc81",
          green = "#a8be81",
          teal = "#9cd1bb",
          sky = "#A6C9E5",
          sapphire = "#86AACC",
          blue = "#5d81ab",
          mauve = "#b18eab",
          text = "#fcfcfa",
          -- subtext1 = "#c0c1b5",
          -- subtext0 = "#b2b9bd",
          -- overlay2 = "#a9b1d6",
          -- overlay1 = "#888d94",
          -- overlay0 = "#6C6168",
          surface2 = "#535763",
          surface1 = "#3a3d4b",
          surface0 = "#30303b",
          base = "#202027",
          mantle = "#1c1d22",
          crust = "#171719",
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
    }
  end,
}
