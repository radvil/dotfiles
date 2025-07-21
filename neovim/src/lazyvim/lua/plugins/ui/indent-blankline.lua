local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "LazyFile",
  main = "ibl",
  enabled = false
}

M.keys = {
  {
    "<leader>ui",
    "<cmd>IBLToggle<CR>",
    desc = "toggle indentation guide",
  },
}

M.opts = {
  enabled = true,
  indent = {
    char = { "│", "»", "┊", "»" },
  },
  scope = {
    enabled = false,
  },
  exclude = {
    buftypes = { "teminal" },
    filetypes = {
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
      "git",
      "qf",

      -- popup
      "TelescopeResults",
      "TelescopePrompt",
      "neo-tree-popup",
      "DressingInput",
      "flash_prompt",
      "oil_preview",
      "cmp_menu",
      "WhichKey",
      "lspinfo",
      "notify",
      "noice",
      "mason",
      "lazy",
      "oil",
    },
  },
}

return M
