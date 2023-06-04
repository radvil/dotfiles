local env = function()
  return rvim.theme
end

---@type LazySpec
local M = {}
M[1] = "catppuccin/nvim"
M.name = "catppuccin"
-- M.lazy = true
M.opts = {
  flavour = env().variant, -- latte, frappe, macchiato, mocha
  transparent_background = env().transbg,
  term_colors = true,
  dim_inactive = {
    enabled = false,
    percentage = 0.15,
    shade = "dark",
  },
  background = {
    light = "latte",
    dark = "mocha",
  },
  styles = {
    conditionals = { "italic" },
    comments = { "italic" },
  },
  integrations = {
    treesitter = true,
    coc_nvim = false,
    lsp_trouble = true,
    cmp = true,
    lsp_saga = false,
    leap = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    which_key = true,
    dashboard = false,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = false,
    ts_rainbow = false,
    hop = true,
    notify = true,
    telekasten = false,
    symbols_outline = true,
    mini = true,
    navic = false,
    noice = true,
    fidget = false,
    neotree = true,
    nvimtree = {
      enabled = true,
      transparent_panel = env().transbg,
      show_root = true,
    },
    dap = {
      enabled = false,
      enable_ui = false,
    },
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        information = { "italic" },
        warnings = { "italic" },
        errors = { "italic" },
        hints = { "italic" },
      },
      underlines = {
        information = { "underline" },
        warnings = { "underline" },
        errors = { "underline" },
        hints = { "underline" },
      },
    },
  },
}
if env().colorscheme == "catppuccin" then
  M.priority = 999
  M.lazy = false
  M.init = function()
    vim.cmd("colorscheme catppuccin")
  end
end
return M
