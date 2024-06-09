-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_user_command("BAD", function()
  local current_bufnr = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buftype == "" and bufnr ~= current_bufnr then
      LazyVim.ui.bufremove(bufnr)
    end
  end
  vim.schedule(function()
    vim.cmd("ls")
  end)
end, { desc = "Delete all buffers" })
