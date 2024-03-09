---@param transparent? boolean
---@param styles? ("bold" | "italic")[]
local function get_custom_catppuccin_hls(transparent, styles)
  local ctp = require("catppuccin")
  local C = require("catppuccin.palettes").get_palette()
    --stylua: ignore
    if not C then return {} end
  local O = ctp.options
  local active_bg = C.surface0
  local inactive_bg = C.mantle
  local separator_fg = C.crust
  local fill_bg = C.crust
  if transparent == true then
    separator_fg = C.surface1
    fill_bg = C.mantle
  end
  local highlights = {
    fill = { bg = fill_bg },
    background = { bg = inactive_bg },
    buffer_visible = { fg = C.surface1, bg = inactive_bg },
    buffer_selected = { fg = C.text, bg = active_bg, style = styles }, -- current
    duplicate_selected = { fg = C.text, bg = active_bg, style = styles },
    duplicate_visible = { fg = C.surface1, bg = inactive_bg, style = styles },
    duplicate = { fg = C.surface1, bg = inactive_bg, style = styles },
    tab = { fg = C.surface1, bg = inactive_bg },
    tab_selected = { fg = C.sky, bg = active_bg, bold = true },
    tab_separator = { fg = separator_fg, bg = inactive_bg },
    tab_separator_selected = { fg = separator_fg, bg = active_bg },
    tab_close = { fg = C.red, bg = inactive_bg },
    indicator_selected = { fg = C.peach, bg = active_bg, style = styles },
    separator = { fg = separator_fg, bg = inactive_bg },
    separator_visible = { fg = separator_fg, bg = inactive_bg },
    separator_selected = { fg = separator_fg, bg = active_bg },
    offset_separator = { fg = separator_fg, bg = C.base },
    close_button = { fg = C.surface1, bg = inactive_bg },
    close_button_visible = { fg = C.surface1, bg = inactive_bg },
    close_button_selected = { fg = C.red, bg = active_bg },
    numbers = { fg = C.subtext0, bg = inactive_bg },
    numbers_visible = { fg = C.subtext0, bg = inactive_bg },
    numbers_selected = { fg = C.subtext0, bg = active_bg, style = styles },
    error = { fg = C.red, bg = inactive_bg },
    error_visible = { fg = C.red, bg = inactive_bg },
    error_selected = { fg = C.red, bg = active_bg, style = styles },
    error_diagnostic = { fg = C.red, bg = inactive_bg },
    error_diagnostic_visible = { fg = C.red, bg = inactive_bg },
    error_diagnostic_selected = { fg = C.red, bg = active_bg },
    warning = { fg = C.yellow, bg = inactive_bg },
    warning_visible = { fg = C.yellow, bg = inactive_bg },
    warning_selected = { fg = C.yellow, bg = active_bg, style = styles },
    warning_diagnostic = { fg = C.yellow, bg = inactive_bg },
    warning_diagnostic_visible = { fg = C.yellow, bg = inactive_bg },
    warning_diagnostic_selected = { fg = C.yellow, bg = active_bg },
    info = { fg = C.sky, bg = inactive_bg },
    info_visible = { fg = C.sky, bg = inactive_bg },
    info_selected = { fg = C.sky, bg = active_bg, style = styles },
    info_diagnostic = { fg = C.sky, bg = inactive_bg },
    info_diagnostic_visible = { fg = C.sky, bg = inactive_bg },
    info_diagnostic_selected = { fg = C.sky, bg = active_bg },
    hint = { fg = C.teal, bg = inactive_bg },
    hint_visible = { fg = C.teal, bg = inactive_bg },
    hint_selected = { fg = C.teal, bg = active_bg, style = styles },
    hint_diagnostic = { fg = C.teal, bg = inactive_bg },
    hint_diagnostic_visible = { fg = C.teal, bg = inactive_bg },
    hint_diagnostic_selected = { fg = C.teal, bg = active_bg },
    diagnostic = { fg = C.subtext0, bg = inactive_bg },
    diagnostic_visible = { fg = C.subtext0, bg = inactive_bg },
    diagnostic_selected = { fg = C.subtext0, bg = active_bg, style = styles },
    modified = { fg = C.peach, bg = inactive_bg },
    modified_selected = { fg = C.peach, bg = active_bg },
  }
  for _, color in pairs(highlights) do
    -- Because default is gui=bold,italic
    color.italic = false
    color.bold = false
    if color.style then
      for _, style in pairs(color.style) do
        color[style] = true
        if O.no_italic and style == "italic" then
          color[style] = false
        end
        if O.no_bold and style == "bold" then
          color[style] = false
        end
      end
    end
    color.style = nil
  end
  return highlights
end

return {
  "akinsho/bufferline.nvim",
  lazy = false,
  keys = function()
    local Kmap = function(lhs, cmd, desc)
      cmd = string.format("<cmd>BufferLine%s<cr>", cmd)
      desc = string.format("Buffer » %s", desc)
      return { lhs, cmd, desc = desc }
    end
    return {
      Kmap("<a-b>", "Pick", "Pick"),
      Kmap("<a-q>", "PickClose", "Pick & close"),
      Kmap("<leader>bS", "SortByTabs", "Sort by tabs"),
      Kmap("<leader>bs", "SortByDirectory", "Sort by directory"),
      Kmap("<leader>bp", "TogglePin", "Toggle pin"),
      Kmap("<a-.>", "MoveNext", "Shift right"),
      Kmap("<a-,>", "MovePrev", "Shift left"),
      Kmap("<a-[>", "CyclePrev", "Switch prev"),
      Kmap("<a-]>", "CycleNext", "Switch next"),
      Kmap("<a-1>", "GoToBuffer 1", "Switch 1st"),
      Kmap("<a-2>", "GoToBuffer 2", "Switch 2nd"),
      Kmap("<a-3>", "GoToBuffer 3", "Switch 3rd"),
      Kmap("<a-4>", "GoToBuffer 4", "Switch 4th"),
      Kmap("<a-5>", "GoToBuffer 5", "Switch 5th"),
      Kmap("<leader>bB", "CloseLeft", "Close left"),
      Kmap("<leader>bW", "CloseRight", "Close right"),
      Kmap("<leader>bC", "CloseOthers", "Close others"),
    }
  end,

  config = function()
    vim.opt.mousemoveevent = true
    local show_cwd = vim.g.neovide or os.getenv("TMUX") == nil
    local opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        show_close_icon = false,
        move_wraps_at_ends = true,
        show_buffer_icons = true,
        show_tab_indicators = true,
        always_show_bufferline = true,
        ---@type "thin" | "padded_slant" | "slant" | "thick" | "none"
        separator_style = "thin",
        ---@type "insert_after_current" | "insert_at_end" | "id" | "extension" | "relative_directory" | "directory" | "tabs"
        sort_by = "insert_after_current",
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        right_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        indicator = {
          ---@type "icon" | "underline" | "none"
          style = "icon",
        },
        hover = {
          enabled = true,
          reveal = { "close" },
          delay = 200,
        },
        offsets = {
          {
            filetype = "neo-tree",
            text_align = show_cwd and "left" or "center",
            text = function()
              return show_cwd and "CWD » " .. vim.fn.getcwd() or "~ TREE VIEW ~"
            end,
            highlight = "BufferLineFill",
            separator = true,
          },
        },
      },
    }

    local Utils = require("utils")
    local Prefer = require("preferences")
    if Utils.call("catppuccin") and string.match(vim.g.colors_name, "catppuccin") then
      opts.highlights = get_custom_catppuccin_hls(Prefer.transparent)
    end

    require("bufferline").setup(opts)
  end,
}
