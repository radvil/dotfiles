local M = {}

function M.catppuccin()
  return function()
    local ctp = require("catppuccin")
    local C = require("catppuccin.palettes").get_palette()
    --stylua: ignore                              
    if not C then return {} end
    local O = ctp.options
    local active_bg = C.surface0
    local inactive_bg = C.mantle
    local separator_fg = C.crust
    local fill_bg = C.base
    local highlights = {
      fill = { bg = fill_bg },
      background = { bg = inactive_bg },
      buffer_visible = { fg = C.surface1, bg = inactive_bg },
      buffer_selected = { fg = C.text, bg = active_bg }, -- current
      duplicate_selected = { fg = C.text, bg = active_bg },
      duplicate_visible = { fg = C.surface1, bg = inactive_bg },
      duplicate = { fg = C.surface1, bg = inactive_bg },
      tab = { fg = C.surface1, bg = inactive_bg },
      tab_selected = { fg = C.sky, bg = active_bg, bold = true },
      tab_separator = { fg = separator_fg, bg = inactive_bg },
      tab_separator_selected = { fg = separator_fg, bg = active_bg },
      tab_close = { fg = C.red, bg = inactive_bg },
      indicator_selected = { fg = C.peach, bg = active_bg },
      separator = { fg = C.surface1, bg = inactive_bg },
      separator_visible = { fg = separator_fg, bg = inactive_bg },
      separator_selected = { fg = separator_fg, bg = active_bg },
      offset_separator = { link = "WinSeparator" },
      close_button = { fg = C.surface1, bg = inactive_bg },
      close_button_visible = { fg = C.surface1, bg = inactive_bg },
      close_button_selected = { fg = C.red, bg = active_bg },
      numbers = { fg = C.subtext0, bg = inactive_bg },
      numbers_visible = { fg = C.subtext0, bg = inactive_bg },
      numbers_selected = { fg = C.subtext0, bg = active_bg },
      error = { fg = C.red, bg = inactive_bg },
      error_visible = { fg = C.red, bg = inactive_bg },
      error_selected = { fg = C.red, bg = active_bg },
      error_diagnostic = { fg = C.red, bg = inactive_bg },
      error_diagnostic_visible = { fg = C.red, bg = inactive_bg },
      error_diagnostic_selected = { fg = C.red, bg = active_bg },
      warning = { fg = C.yellow, bg = inactive_bg },
      warning_visible = { fg = C.yellow, bg = inactive_bg },
      warning_selected = { fg = C.yellow, bg = active_bg },
      warning_diagnostic = { fg = C.yellow, bg = inactive_bg },
      warning_diagnostic_visible = { fg = C.yellow, bg = inactive_bg },
      warning_diagnostic_selected = { fg = C.yellow, bg = active_bg },
      info = { fg = C.sky, bg = inactive_bg },
      info_visible = { fg = C.sky, bg = inactive_bg },
      info_selected = { fg = C.sky, bg = active_bg },
      info_diagnostic = { fg = C.sky, bg = inactive_bg },
      info_diagnostic_visible = { fg = C.sky, bg = inactive_bg },
      info_diagnostic_selected = { fg = C.sky, bg = active_bg },
      hint = { fg = C.teal, bg = inactive_bg },
      hint_visible = { fg = C.teal, bg = inactive_bg },
      hint_selected = { fg = C.teal, bg = active_bg },
      hint_diagnostic = { fg = C.teal, bg = inactive_bg },
      hint_diagnostic_visible = { fg = C.teal, bg = inactive_bg },
      hint_diagnostic_selected = { fg = C.teal, bg = active_bg },
      diagnostic = { fg = C.subtext0, bg = inactive_bg },
      diagnostic_visible = { fg = C.subtext0, bg = inactive_bg },
      diagnostic_selected = { fg = C.subtext0, bg = active_bg },
      modified = { fg = C.peach, bg = inactive_bg },
      modified_selected = { fg = C.peach, bg = active_bg },
    }
    for _, hi in pairs(highlights) do
      -- Because default is gui=bold,italic
      hi.italic = false
      hi.bold = false
      if hi.style then
        for _, style in pairs(hi.style) do
          hi[style] = true
          if O.no_italic and style == "italic" then
            hi[style] = false
          end
          if O.no_bold and style == "bold" then
            hi[style] = false
          end
        end
      end
      hi.style = nil
    end
    return highlights
  end
end

function M.kanagawa()
  return function()
    local theme = require("kanagawa.colors").setup().theme
    if not theme then
      return {}
    end
    -- local active_bg = theme.ui.bg_p1
    local active_bg = "none"
    local inactive_bg = theme.ui.bg_m1
    local inactive_text = theme.ui.nontext
    local text = theme.ui.fg
    local text_alt = theme.ui.fg_dim
    local separator_fg = theme.ui.bg_m2
    -- local fill_bg = inactive_bg
    -- local fill_bg = 'none'
    local fill_bg = theme.ui.bg_m3
    return {
      fill = { bg = fill_bg },
      background = { bg = inactive_bg },
      buffer_visible = { fg = inactive_text, bg = inactive_bg },
      buffer_selected = { fg = text, bg = active_bg }, -- current
      duplicate_selected = { fg = text, bg = active_bg },
      duplicate_visible = { fg = inactive_text, bg = inactive_bg },
      duplicate = { fg = inactive_text, bg = inactive_bg },
      tab = { fg = inactive_text, bg = inactive_bg },
      tab_selected = { fg = text, bg = active_bg, bold = true },
      tab_separator = { fg = separator_fg, bg = inactive_bg },
      tab_separator_selected = { fg = separator_fg, bg = active_bg },
      tab_close = { fg = theme.diag.error, bg = inactive_bg },
      indicator_selected = { fg = theme.vcs.changed, bg = active_bg },
      separator = { fg = inactive_text, bg = inactive_bg },
      separator_visible = { fg = separator_fg, bg = inactive_bg },
      separator_selected = { fg = separator_fg, bg = active_bg },
      offset_separator = { link = "WinSeparator" },
      close_button = { fg = inactive_text, bg = inactive_bg },
      close_button_visible = { fg = inactive_text, bg = inactive_bg },
      close_button_selected = { fg = theme.diag.error, bg = active_bg },
      numbers = { fg = text_alt, bg = inactive_bg },
      numbers_visible = { fg = text_alt, bg = inactive_bg },
      numbers_selected = { fg = text_alt, bg = active_bg },
      error = { fg = theme.diag.error, bg = inactive_bg },
      error_visible = { fg = theme.diag.error, bg = inactive_bg },
      error_selected = { fg = theme.diag.error, bg = active_bg },
      error_diagnostic = { fg = theme.diag.error, bg = inactive_bg },
      error_diagnostic_visible = { fg = theme.diag.error, bg = inactive_bg },
      error_diagnostic_selected = { fg = theme.diag.error, bg = active_bg },
      warning = { fg = theme.diag.warning, bg = inactive_bg },
      warning_visible = { fg = theme.diag.warning, bg = inactive_bg },
      warning_selected = { fg = theme.diag.warning, bg = active_bg },
      warning_diagnostic = { fg = theme.diag.warning, bg = inactive_bg },
      warning_diagnostic_visible = { fg = theme.diag.warning, bg = inactive_bg },
      warning_diagnostic_selected = { fg = theme.diag.warning, bg = active_bg },
      info = { fg = theme.diag.info, bg = inactive_bg },
      info_visible = { fg = theme.diag.info, bg = inactive_bg },
      info_selected = { fg = theme.diag.info, bg = active_bg },
      info_diagnostic = { fg = theme.diag.info, bg = inactive_bg },
      info_diagnostic_visible = { fg = theme.diag.info, bg = inactive_bg },
      info_diagnostic_selected = { fg = theme.diag.info, bg = active_bg },
      hint = { fg = theme.diag.hint, bg = inactive_bg },
      hint_visible = { fg = theme.diag.hint, bg = inactive_bg },
      hint_selected = { fg = theme.diag.hint, bg = active_bg },
      hint_diagnostic = { fg = theme.diag.hint, bg = inactive_bg },
      hint_diagnostic_visible = { fg = theme.diag.hint, bg = inactive_bg },
      hint_diagnostic_selected = { fg = theme.diag.hint, bg = active_bg },
      diagnostic = { fg = text_alt, bg = inactive_bg },
      diagnostic_visible = { fg = text_alt, bg = inactive_bg },
      diagnostic_selected = { fg = text_alt, bg = active_bg },
      modified = { fg = theme.vcs.changed, bg = inactive_bg },
      modified_selected = { fg = theme.vcs.changed, bg = active_bg },
    }
  end
end

function M.tokyonight()
  return function()
    local colors = {
      base = vim.g.neo_transparent and "NONE" or "#222436",
      dark = "#1E1E2E",
      darker = "#181826",
      surface2 = "#585b70",
      surface1 = "#45475a",
      surface0 = "#313244",
      text = "#cdd6f4",
      subtext = "#a6adc8",
      blue = "#82aaff",
      red = "#ff757f",
      orange = "#ff966c",
      yellow = "#ffc777",
      teal = "#4fd6be",
    }
    local stroke = vim.g.neo_transparent and colors.surface1 or "#0d0e18"
    return {
      fill = { bg = colors.darker },
      background = { bg = colors.dark },
      buffer_visible = { fg = colors.surface1, bg = colors.dark },
      buffer_selected = { fg = colors.text, bold = false, italic = false },
      duplicate_selected = { fg = colors.text, bg = colors.base },
      duplicate_visible = { fg = colors.surface1, bg = colors.dark },
      duplicate = { fg = colors.surface1, bg = colors.dark },
      tab = { fg = colors.surface1, bg = colors.dark },
      tab_selected = { fg = colors.blue },
      tab_separator = { fg = stroke, bg = colors.dark },
      tab_separator_selected = { fg = stroke, bg = stroke },
      tab_close = { fg = colors.red, bg = colors.dark },
      indicator_selected = { fg = colors.orange, bg = colors.base },
      separator = { fg = stroke, bg = colors.dark },
      separator_visible = { fg = stroke, bg = colors.dark },
      separator_selected = { fg = stroke, bg = colors.base },
      offset_separator = { fg = stroke, bg = colors.base },
      close_button = { fg = colors.surface1, bg = colors.dark },
      close_button_visible = { fg = colors.surface1, bg = colors.dark },
      close_button_selected = { fg = colors.red, bg = colors.base },
      numbers = { fg = colors.subtext, bg = colors.dark },
      numbers_visible = { fg = colors.subtext, bg = colors.dark },
      numbers_selected = { fg = colors.subtext, bg = colors.base },
      error = { fg = colors.red, bg = colors.dark },
      error_visible = { fg = colors.red, bg = colors.dark },
      error_selected = { fg = colors.red, bg = colors.base },
      error_diagnostic = { fg = colors.red, bg = colors.dark },
      error_diagnostic_visible = { fg = colors.red, bg = colors.dark },
      error_diagnostic_selected = { fg = colors.red, bg = colors.base },
      warning = { fg = colors.yellow, bg = colors.dark },
      warning_visible = { fg = colors.yellow, bg = colors.dark },
      warning_selected = { fg = colors.yellow, bg = colors.base },
      warning_diagnostic = { fg = colors.yellow, bg = colors.dark },
      warning_diagnostic_visible = { fg = colors.yellow, bg = colors.dark },
      warning_diagnostic_selected = { fg = colors.yellow, bg = colors.base },
      info = { fg = colors.blue, bg = colors.dark },
      info_visible = { fg = colors.blue, bg = colors.dark },
      info_selected = { fg = colors.blue, bg = colors.base },
      info_diagnostic = { fg = colors.blue, bg = colors.dark },
      info_diagnostic_visible = { fg = colors.blue, bg = colors.dark },
      info_diagnostic_selected = { fg = colors.blue, bg = colors.base },
      hint = { fg = colors.teal, bg = colors.dark },
      hint_visible = { fg = colors.teal, bg = colors.dark },
      hint_selected = { fg = colors.teal, bg = colors.base },
      hint_diagnostic = { fg = colors.teal, bg = colors.dark },
      hint_diagnostic_visible = { fg = colors.teal, bg = colors.dark },
      hint_diagnostic_selected = { fg = colors.teal, bg = colors.base },
      diagnostic = { fg = colors.subtext, bg = colors.dark },
      diagnostic_visible = { fg = colors.subtext, bg = colors.dark },
      diagnostic_selected = { fg = colors.subtext, bg = colors.base },
      modified = { fg = colors.orange, bg = colors.dark },
      modified_selected = { fg = colors.orange, bg = colors.base },
    }
  end
end

return M
