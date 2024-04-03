local base = {
  red = "#ff657a",
  maroon = "#F29BA7",
  peach = "#ff9b5e",
  yellow = "#eccc81",
  green = "#a8be81",
  teal = "#9cd1bb",
  sky = "#A6C9E5",
  sapphire = "#86AACC",
  blue = "#5d81ab",
  lavender = "#949EBA",
  mauve = "#b18eab",
}

---@param value table<string, string>
local extend_base = function(value)
  return vim.tbl_extend("force", base, value)
end

return {
  "catppuccin",
  optional = true,
  opts = function()
    ---@type CatppuccinOptions
    return {
      background = {
        dark = "frappe",
        light = "latte",
      },
      color_overrides = {
        latte = extend_base({
          text = "#202027",
          subtext1 = "#263168",
          subtext0 = "#4c4f69",
          overlay2 = "#737994",
          overlay1 = "#838ba7",
          base = "#fcfcfa",
          mantle = "#EAEDF3",
          crust = "#DCE0E8",
          pink = "#EA7A95",
          mauve = "#986794",
          red = "#EC5E66",
          peach = "#FF8459",
          yellow = "#CAA75E",
          green = "#87A35E",
          lavender = "#66729C",
        }),
        frappe = extend_base({
          text = "#fcfcfa",
          surface2 = "#535763",
          surface1 = "#3a3d4b",
          surface0 = "#30303b",
          base = "#202027",
          mantle = "#1c1d22",
          crust = "#171719",
        }),
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
        cmp = true,
        dap = false,
        dropbar = false,
        flash = false,
        gitsigns = true,
        harpoon = true,
        headlines = false,
        illuminate = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        mini = false,
        navic = {
          enabled = true,
          custom_bg = "lualine",
        },
        neotree = true,
        noice = false,
        notify = false,
        nvimtree = false,
        treesitter = true,
        ts_rainbow2 = false,
        which_key = true,
      },
    }
  end,
}
