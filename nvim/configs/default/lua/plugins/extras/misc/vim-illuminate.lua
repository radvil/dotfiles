return {
  {
    "folke/snacks.nvim",
    opts = {
      words = { enabled = false },
    },
  },
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
        delay = 100,
        under_cursor = true,
        large_file_cutoff = 2000,
        -- large_file_overrides = nil,
        large_file_overrides = {
          providers = { "lsp" },
        },
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
}
