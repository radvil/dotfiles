local function reset_presets_labels()
  local presets = require("which-key.plugins.presets")
  presets.operators["v"] = nil
  presets.operators["gc"] = "Comments"

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
  presets.motions["<M-i>"] = [[variable or value]]
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    show_help = false,
    window = {
      position = "bottom",
      margin = { 0, 0, 0, 0 },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "🔸",
    },
    layout = {
      spacing = 2,
    },
    disable = {
      buftypes = { "terminal" },
      filetypes = require("common.filetypes").Excludes,
    },
  },

  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
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
      ["<Leader>u"] = { name = "Toggle" },
      ["<Leader>n"] = { name = "Noice/Notify" },
      ["<leader>t"] = { name = "Tabs" },
      ["<leader>c"] = { name = "Code action" },
      ["-"] = { name = "Surrounding" },
    })
    reset_presets_labels()
  end,
}
