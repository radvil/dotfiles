---@type LazySpec
local M = {}
M[1] = "folke/which-key.nvim"
M.event = "VeryLazy"
M.enabled = rvim.whichkey.enabled

M.opts = {
  window = {
    border = "",
    -- [top, right, bottom, left]
    -- margin = { 1, 1, 1, 1 },
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
  disable = {
    buftypes = { "terminal" },
    filetypes = require("opt.filetype").excludes,
  },
}

M.init = function()
  local wk = require("which-key")
  wk.register({
    ["<Leader>/"] = { name = "Telescope" },
    ["<Leader>x"] = { name = "Diagnostics" },
    ["<Leader>b"] = { name = "Buffer" },
    ["<Leader>w"] = { name = "Window" },
    ["<Leader>m"] = { name = "Tmux" },
    ["<Leader>s"] = { name = "Spectre" },
    ["<Leader>S"] = { name = "Session" },
    ["<Leader>f"] = { name = "Float" },
    ["<Loader>g"] = { name = "Git" },
    ["so"] = { name = "Surrond textobject" },
  })
end

return M
