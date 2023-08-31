return {
  "stevearc/oil.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  enabled = true,

  keys = {
    {
      "<Leader>fe",
      function()
        require("oil").open()
      end,
      desc = "Float » Explorer (pwd)",
    },
    {
      "<Leader>fE",
      function()
        require("oil").open(vim.loop.cwd())
      end,
      desc = "Float » Explorer (cwd)",
    },
  },

  opts = {
    delete_to_trash = false, -- 'false' to use trash
    restore_win_options = true,
    trash_command = "trash-put",
    skip_confirm_for_simple_edits = false,
    prompt_save_on_select_new_entry = true,
    default_file_explorer = true,
    buf_options = { buflisted = false },
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["q"] = "actions.close",
      ["<cr>"] = "actions.select",
      ["^"] = "actions.open_cwd",
      ["H"] = "actions.toggle_hidden",
      ["gx"] = "actions.select_vsplit",
      ["gy"] = "actions.select_split",
      ["-"] = "actions.parent",
      ["K"] = "actions.preview",
      ["<leader>r"] = "actions.refresh",
    },
    win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "n",
    },
    float = {
      padding = 2,
      max_width = 96,
      max_height = 45,
      border = minimal.transbg and "single" or "none",
      win_options = { winblend = 0 },
    },
  },

  deactivate = function()
    vim.cmd([[Oil close]])
  end,
}
