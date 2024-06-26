return {
  {
    "RRethy/vim-illuminate",

    keys = {
      {
        "<a-p>",
        function()
          require("illuminate").goto_prev_reference(false)
        end,
        desc = "vim illuminate » prev ref",
        mode = { "n", "x", "o", "v" },
      },
      {
        "<a-n>",
        function()
          require("illuminate").goto_next_reference(false)
        end,
        desc = "vim illuminate » next ref",
        mode = { "n", "x", "o", "v" },
      },
    },

    config = function()
      require("illuminate").configure({
        delay = 200,
        under_cursor = false,
        large_file_cutoff = 2000,
        large_file_overrides = nil,
        filetypes_denylist = {
          "fugitiveblame",
          "DiffviewFiles",
          "NeogitStatus",
          "Dashboard",
          "dashboard",
          "MundoDiff",
          "gitcommit",
          "NvimTree",
          "fugitive",
          "neo-tree",
          "Outline",
          "Trouble",
          "harpoon",
          "prompt",
          "dirbuf",
          "alpha",
          "Mundo",
          "dbui",
          "help",
          "edgy",
          "oil",
          "qf",
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      LazyVim.lsp.words.enabled = false
    end,
  },
}
