---@alias OneDarkVariant "dark" |"darker" |"cool" | "deep" | "warm" | "warmer" | "light"

local bg_default = {
  ---@type OneDarkVariant
  dark = "darker",
  ---@type OneDarkVariant
  light = "light",
}

local next = nil

return {
  "navarasu/onedark.nvim",
  name = "onedark",
  lazy = not string.match(vim.g.neo_colorscheme, "onedark"),
  opts = {
    ------@type "dark" |"darker" |"cool" | "deep" | "warm" | "warmer" | "light"
    term_colors = true,
    ending_tildes = false,
    cmp_itemkind_reverse = false,
    toggle_style_key = nil,
    toggle_style_list = {
      "dark",
      "darker",
      "cool",
      "deep",
      "warm",
      "warmer",
      "light",
    },
    code_style = {
      comments = "italic",
      keywords = "none",
      functions = "none",
      strings = "none",
      variables = "none",
    },
    lualine = {
      transparent = false,
    },
    colors = {},
    highlights = {},
    diagnostics = {
      darker = true,
      undercurl = true,
      background = true,
    },
  },
  config = function(_, opts)
    local transparent = vim.g.neo_transparent and vim.o.background ~= "light"
    opts.transparent = transparent
    opts.style = next or bg_default[vim.o.background]
    require("onedark").setup(opts)
  end,
  init = function()
    local augroup = vim.api.nvim_create_augroup("neo_autocmds", { clear = true })
    vim.api.nvim_create_autocmd("OptionSet", {
      group = augroup,
      pattern = "background",
      desc = "On Background Changed",
      callback = function()
        if string.match(vim.g.colors_name, "onedark") then
          if vim.v.option_old == vim.v.option_new then
            return
          else
            next = vim.v.option_new == "dark" and bg_default.light or bg_default.dark
            vim.schedule(function()
              vim.cmd.Lazy("reload onedark")
            end)
          end
        end
      end,
    })
  end,
}
