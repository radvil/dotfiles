local palette = require("neoverse.config").palette

return {
  "catppuccin",
  optional = true,
  opts = function()
    ---@type CatppuccinOptions
    return {
      flavour = vim.g.neovide and "mocha" or "frappe",
      dim_inactive = {
        enabled = false,
        percentage = 0.13,
        shade = "dark",
      },
      color_overrides = {
        mocha = {
          surface0 = palette.dark2,
        },
        frappe = {
          red = "#ff657a", -- "#f92672",
          maroon = "#ea999c",
          peach = "#ff9b5e",
          yellow = "#ffd76d",
          green = "#bad761",
          teal = "#9cd1bb",
          sky = "#78dce8",
          -- sapphire = "#0db9d7",
          blue = "#7796d8",
          mauve = "#c39ac9",
          text = "#eaf2f1",
          subtext1 = "#c0c1b5",
          subtext0 = "#b2b9bd",
          -- overlay2 = "#a9b1d6",
          overlay1 = "#888d94",
          overlay0 = "#696d77",
          surface2 = "#535763",
          surface1 = "#3a3d4b",
          surface0 = palette.dark2,
          base = "#282a3a",
          mantle = "#1e1f2b",
          crust = "#161821",
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
