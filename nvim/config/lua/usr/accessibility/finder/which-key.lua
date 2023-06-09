---@type LazySpec
local M = {}
M[1] = "folke/which-key.nvim"
M.event = "VeryLazy"
M.enabled = rvim.whichkey.enabled

M.opts = {
  window = {
    border = "",
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "🔸",
  },
  layout = {
    spacing = 7,
  },
  disable = {
    buftypes = { "terminal" },
    filetypes = require("opt.filetype").excludes,
  },
  -- ignore_missing = true,
  show_help = false,
  triggers_nowait = {
    -- marks
    "`",
    "'",
    "g`",
    "g'",
    -- registers
    '"',
    "<c-r>",
    -- spelling
    "z=",
  }
}
local function reset_presets_labels()
  local presets = require("which-key.plugins.presets")

  presets.operators["v"] = nil
  presets.operators["so"] = "Surround » open/add"
  presets.operators["sd"] = "Surround » delete"
  presets.operators["s]"] = "Surround » find next"
  presets.operators["s["] = "Surround » find prev"
  presets.operators["ss"] = "Surround » replace/subt"
  presets.operators["sh"] = "Surround » highlight"

  presets.objects["iW"] = nil
  presets.objects['i"'] = nil
  presets.objects["i'"] = nil
  presets.objects["i("] = nil
  presets.objects["i)"] = nil
  presets.objects["i{"] = nil
  presets.objects["i}"] = nil
  presets.objects["i["] = nil
  presets.objects["i]"] = nil
  presets.objects["i<lt>"] = nil
  presets.objects["i>"] = nil
  presets.objects["i`"] = nil
  presets.objects["aW"] = nil
  presets.objects['a"'] = nil
  presets.objects["a'"] = nil
  presets.objects["a("] = nil
  presets.objects["a)"] = nil
  presets.objects["a{"] = nil
  presets.objects["a}"] = nil
  presets.objects["a["] = nil
  presets.objects["a]"] = nil
  presets.objects["a<lt>"] = nil
  presets.objects["a>"] = nil
  presets.objects["a`"] = nil
  presets.objects["ab"] = [[block [( » ])]]
  presets.objects["aB"] = [[block [{ » ]}]]
  presets.objects["ap"] = [[paragraph]]
  presets.objects["at"] = [[tag]]
  presets.objects["aw"] = [[word]]
  presets.objects["as"] = [[sentence]]

  presets.motions["w"] = "Forward"
  presets.motions["b"] = "Backward"
  presets.motions["T"] = "To prev char of <input>"
  presets.motions["t"] = "To next char of <input>"
  presets.motions["F"] = "Find prev char of <input>"
  presets.motions["f"] = "Find next char of <input>"
  presets.motions["ge"] = "End of prev word"
  presets.motions["e"] = "End of next word"
  presets.motions["%"] = "Match '()' or '{}' or '[]'"
  presets.motions["^"] = "Start of sentence"
  presets.motions["_"] = "Entire line"
  presets.motions["0"] = "Start of line"
  presets.motions["$"] = "End of sentence"
end
M.init = function()
  local wk = require("which-key")
  reset_presets_labels()
  wk.register({
    ["<Leader>/"] = { name = "Telescope" },
    ["<Leader>x"] = { name = "Diagnostics" },
    ["<Leader>b"] = { name = "Buffer" },
    ["<Leader>w"] = { name = "Window" },
    ["<Leader>m"] = { name = "Tmux" },
    ["<Leader>s"] = { name = "Spectre" },
    ["<Leader>S"] = { name = "Session" },
    ["<Leader>f"] = { name = "Float" },
    ["<Leader>g"] = { name = "Git" },
    ["<Leader>j"] = { name = "Javascript actions" },
    ["c<M-i>"] = { name = "Change variable or value" },
    ["s"] = { name = "Surround" },
  })
end

return M
