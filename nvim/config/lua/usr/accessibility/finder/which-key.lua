---@type LazySpec
local M = {}
M[1] = "folke/which-key.nvim"
M.event = "VeryLazy"
M.enabled = rvim.whichkey.enabled
M.opts = {
  window = {
    border = "single",
    -- [top, right, bottom, left]
    margin = { 1, 1, 1, 1 },
  },
  icons = {
    -- symbol used in the command line area that shows your active key combo
    breadcrumb = "»",
    separator = "➜",
    group = "🔸",
  },
  layout = {
    spacing = 7,
    align = "center",
  },
  key_labels = {
    ["<leader>"] = "Leader",
    ["<space>"] = "Space",
    ["<bs>"] = "Backspace",
    ["<tab>"] = "Tab",
    ["<esc>"] = "Esc",
  },
  disable = {
    buftypes = { "terminal" },
    filetypes = require("opt.filetype").excludes,
  },
}
M.init = function()
  local wk = require("which-key")
  wk.register({
    ["<Leader>/"] = { name = "Telescope" },
    ["<Leader>x"] = { name = "Problem" },
    ["<Leader>b"] = { name = "Buffer" },
    ["<Leader>w"] = { name = "Window" },
    ["<Localleader>g"] = { name = "Git" },
    ["s"] = { name = "Surrond" },
  })
end
return M
