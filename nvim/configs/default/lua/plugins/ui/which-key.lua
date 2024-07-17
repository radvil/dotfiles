return {
  "which-key.nvim",
  opts = {
    show_help = true,
    notify = false,
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    win = {
      border = vim.g.neo_winborder,
      padding = vim.g.neo_transparent and { 0, 0, 0, 0 } or { 1, 2, 1, 2 },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+ ",
    },
    disable = {
      bt = { "terminal" },
      ft = {
        "DiffviewFiles",
        "NeogitStatus",
        "Dashboard",
        "dashboard",
        "MundoDiff",
        "NvimTree",
        "neo-tree",
        "Outline",
        "prompt",
        "Mundo",
        "alpha",
        "help",
        "dbui",
        "edgy",
        "dirbuf",
        "fugitive",
        "fugitiveblame",
        "gitcommit",
        "Trouble",
        "alpha",
        "help",
        "qf",
      },
      ---@type fun(ctx: { keys: string, mode: string, plugin?: string }):boolean?
      trigger = function(ctx)
        local prefixes = {
          "[",
          "]",
          "z",
          "`",
        }
        return ctx.mode == "n" and vim.tbl_contains(prefixes, ctx.keys)
      end,
    },
    layout = {
      align = "left",
      spacing = 5,
      height = {
        min = 3,
        max = 9,
      },
    },
    spec = {
      mode = { "n", "x" },
      ["g"] = { name = "goto" },
      ["z"] = { name = "fold" },
      ["]"] = { name = "next" },
      ["["] = { name = "previous" },
      ["<leader>/"] = { name = "[/]elescope" },
      ["<leader>x"] = { name = "diagnosti[x]" },
      ["<leader>b"] = { name = "[b]uffer" },
      ["<Leader>c"] = { name = "[c]ode" },
      ["<leader>w"] = { name = "[w]indow" },
      ["<leader>m"] = { name = "[m]iscellaneous" },
      ["<leader>s"] = { name = "[s]pectre" },
      ["<leader>S"] = { name = "[S]ession" },
      ["<leader>f"] = { name = "[f]iles" },
      ["<leader>g"] = { name = "[g]it" },
      ["<leader>u"] = { name = "[u]ndo/toggle" },
      ["<leader>t"] = { name = "[t]erminal" },
    },
  },
}
