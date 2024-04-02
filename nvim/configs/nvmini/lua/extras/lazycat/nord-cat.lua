local base = {
  red = "#bf616a",
  maroon = "#f08c96",
  peach = "#d08770",
  yellow = "#ebcb8b",
  green = "#a3be8c",
  mauve = "#b48ead",
  teal = "#8fbcbb",
  sky = "#81a1c1",
  blue = "#7192bb",
  lavender = "#5e81ac",
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
          text = "#282D39",
          subtext1 = "#2e3440",
          subtext0 = "#3b4252",
          overlay2 = "#737994",
          overlay1 = "#838ba7",
          overlay0 = "#949cbb",
          base = "#eceff4",
          mantle = "#e5e9f0",
          crust = "#d8dee9",
        }),
        frappe = extend_base({
          text = "#eceff4",
          subtext1 = "#e5e9f0",
          subtext0 = "#d8dee9",
          surface1 = "#4c566a",
          surface0 = "#434c5e",
          base = "#3b4252",
          mantle = "#2e3440",
          crust = "#282D39",
        }),
      },
    }
  end,
}
