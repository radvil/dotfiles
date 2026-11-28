local palettes = require("hi.color-palettes")

return {
  "catppuccin",
  opts = {
    background = {
      dark = "frappe",
      light = "latte",
    },
    color_overrides = {
      latte = palettes.meowday,
      mocha = palettes.meowthermal,
      frappe = palettes.kopicat,
      macchiato = palettes.naffee,
    },
  },
}
