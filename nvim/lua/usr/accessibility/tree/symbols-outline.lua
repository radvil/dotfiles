local M = {}

M[1] = "simrat39/symbols-outline.nvim"

M.enabled = rvim.symbols.enabled or false

---@alias symbolopts table<string, {icon:string,hl:string}>
---@param opts symbolopts
local function get_symbols(opts)
  local icons = require("media.icons").KindIcons
  for key, _ in pairs(opts) do
    if opts[key] and icons[key] then
      opts[key].icon = icons[key]
    end
  end
  return opts
end

M.opts = function(opts)
  local highlight_hovered_item = rvim.symbols.highlight_hovered_item or false
  local relative_width = rvim.symbols.relative_width or false
  local position = rvim.symbols.position or "right"
  local wrap = rvim.symbols.wrap or false
  local auto_close = rvim.symbols.auto_close or false
  local symbols = get_symbols(opts.symbols or {})
  local keymaps = vim.tbl_deep_extend("force", opts.keymaps or {}, rvim.symbols.keymaps or {})
  local width = rvim.symbols.width or 25
  return {
    highlight_hovered_item = highlight_hovered_item,
    relative_width = relative_width,
    auto_close = auto_close,
    position = position,
    symbols = symbols,
    keymaps = keymaps,
    width = width,
    wrap = wrap,
    show_guides = true,
    auto_preview = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = false,
    preview_bg_highlight = "Pmenu",
    autofold_depth = nil,
    auto_unfold_hover = true,
    fold_markers = { "", "" },
    lsp_blacklist = {},
    symbol_blacklist = {},
  }
end

M.keys = {
  {
    "<C-z>s",
    "<Cmd>SymbolsOutline<Cr>",
    desc = "⭐ Toggle symbols window",
  },
}

return M
