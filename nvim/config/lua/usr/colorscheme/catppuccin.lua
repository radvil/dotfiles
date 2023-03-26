local env = rvim.theme
local flavour = not env.force_darkmode and "latte" or env.variant or "mocha"
local transbg = not env.force_darkmode and false or env.transbg

---@type LazySpec
local M = {}
M[1] = "catppuccin/nvim"
M.name = "catppuccin"
M.lazy = true
M.opts = {
  transparent_background = transbg,
  term_colors = true,
  dim_inactive = {
    enabled = not rvim.theme.transbg,
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
    neotree = false,
    nvimtree = {
      enabled = true,
      transparent_panel = transbg,
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
if env.colorscheme == "catppuccin" then
  M.priority = 999
  M.lazy = false
  M.init = function()
    vim.g.catppuccin_flavour = flavour
    vim.cmd("colorscheme catppuccin")
  end
end
return M
