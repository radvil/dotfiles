---@diagnostic disable: assign-type-mismatch
-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_user_command("BAD", function()
  local current_bufnr = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buftype == "" and bufnr ~= current_bufnr then
      Snacks.bufdelete(bufnr)
    end
  end
  vim.schedule(function()
    vim.cmd("ls")
  end)
end, { desc = "Delete all buffers" })

-- TODO: Remove autocommand later since I barely use them
vim.api.nvim_create_user_command(
  "NeoDotfiles",
  LazyVim.pick("auto", { cwd = os.getenv("DOTFILES") }),
  { desc = "Searh Dotfiles" }
)

vim.api.nvim_create_user_command(
  "NeoNotes",
  LazyVim.pick("find_files", {
    prompt_title = "🧾[N]otes/Obsidian",
    sorting_strategy = "descending",
    cwd = os.getenv("NOTES_DIR"),
    -- no_ignore = false,
    hidden = false,
  }),
  { desc = "Search Notes" }
)

vim.api.nvim_create_user_command("GD", function()
  vim.lsp.buf.definition()
end, { desc = "Lsp Goto Definition" })

vim.api.nvim_create_user_command("GR", function()
  vim.lsp.buf.definition()
end, { desc = "Lsp Goto Definition" })

vim.keymap.set("n", "<leader>/N", "<cmd>NeoNotes<cr>", { desc = "[N]otes" })
vim.keymap.set("n", "<leader>/D", "<cmd>NeoDotfiles<cr>", { desc = "[D]otfiles" })
