local M = {
  "stevearc/oil.nvim",
  deactivate = function()
    vim.cmd([[Oil close]])
  end,
}

-- stylua: ignore
M.keys = {
  {
    "<a-f>",
    function() require("oil").toggle_float() end,
    desc = "[o]pen current file's dir (float)",
  },
  {
    "<a-d>",
    function() require("oil").open(vim.uv.cwd()) end,
    desc = "[o]pen current working dir (float)",
  },
  {
    "<Leader>fo",
    function() require("oil").open() end,
    desc = "[o]pen current file's dir",
  },
  {
    "<Leader>fO",
    function() require("oil").open_float(vim.uv.cwd()) end,
    desc = "[O]pen current working dir",
  },
}

M.opts = {
  prompt_save_on_select_new_entry = true,
  skip_confirm_for_simple_edits = false,
  default_file_explorer = true,
  use_default_keymaps = false,
  delete_to_trash = true,
  cleanup_delay_ms = 500,
  view_options = { show_hidden = true },
  buf_options = { buflisted = true },
  constrain_cursor = "name",
  lsp_file_methods = {
    enabled = false,
  },
  keymaps = {
    ["q"] = "actions.close",
    ["g?"] = "actions.show_help",
    ["^"] = "actions.open_cwd",
    ["-"] = "actions.parent",
    ["H"] = "actions.toggle_hidden",
    ["<cr>"] = "actions.select",
    ["<c-v>"] = "actions.select_vsplit",
    ["<c-x>"] = "actions.select_split",
    ["<c-t>"] = "actions.select_tab",
    ["<c-o>"] = "actions.open_external",
    ["K"] = "actions.preview",
    ["<leader>r"] = "actions.refresh",
  },
  win_options = {
    concealcursor = "n",
  },
  float = {
    padding = 2,
    max_width = 96,
    max_height = 20,
    border = "single",
    win_options = { winblend = 0 },
  },
}

M.init = function()
  vim.api.nvim_create_user_command("OH", function()
    require("oil").open(nil, { vertical = true })
  end, { desc = "Open oil in vertical split" })
end

return M
