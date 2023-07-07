local oil_nvim = require("rad.core.utils").call("oil")
if not oil_nvim then
  return
end

oil_nvim.setup({
  delete_to_trash = true,
  restore_win_options = true,
  trash_command = "trash-put",
  use_default_keymaps = false,
  skip_confirm_for_simple_edits = false,
  prompt_save_on_select_new_entry = true,
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
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
    max_width = 96,
    max_height = 45,
    border = "none",
    win_options = { winblend = 0 },
  },
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
    ["<leader>r"] = "jctions.refresh",
  },
})
