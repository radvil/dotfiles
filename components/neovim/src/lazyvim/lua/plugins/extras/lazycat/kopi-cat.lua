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
  -- lavender = "#7683B5",
  lavender = "#ACB6D2",
  mauve = "#b18eab",
}

---@param value table<string, string>
local extend_base = function(value)
  return vim.tbl_extend("force", base, value)
end

return {
  "catppuccin",
  opts = {
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
        red = "#EC5E66",
        pink = "#EA7A95",
        mauve = "#986794",
        peach = "#FF8459",
        yellow = "#CAA75E",
        green = "#87A35E",
        lavender = "#66729C",
        teal = "#59858a",
        sky = "#04a5e5",
      }),
      frappe = extend_base({
        text = "#fcfcfa",
        surface2 = "#535763",
        surface1 = "#3a3d4b",
        surface0 = "#30303b",
        -- base = "#23232C",
        base = "#202027",
        mantle = "#1c1d22",
        crust = "#171719",
      }),
    },
  },
}
