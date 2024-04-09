return {
  "RRethy/vim-illuminate",

  keys = function()
    return {
      {
        "<A-p>",
        function()
          require("illuminate").goto_prev_reference(false)
        end,
        desc = "Vim Illuminate » Prev ref",
        mode = { "n", "x", "o" },
      },
      {
        "<A-n>",
        function()
          require("illuminate").goto_next_reference(false)
        end,
        desc = "Vim Illuminate » Next ref",
        mode = { "n", "x", "o" },
      },
    }
  end,

  config = function()
    require("illuminate").configure({
      delay = 200,
      under_cursor = false,
      large_file_cutoff = 2000,
      large_file_overrides = nil,
      -- large_file_overrides = {
      --   providers = { "lsp" },
      -- },
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

  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        if require("utils").buf_has_keymaps({ "<A-n>", "<A-p>" }) then
          pcall(vim.keymap.del, "n", "<A-n>", { buffer = true })
          pcall(vim.keymap.del, "n", "<A-p>", { buffer = true })
        end
      end,
    })
  end,
}
