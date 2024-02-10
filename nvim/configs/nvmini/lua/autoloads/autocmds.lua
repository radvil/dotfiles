local Utils = require("neoverse.utils")

vim.api.nvim_create_autocmd("InsertEnter", {
  group = Utils.create_augroup("cursor_insert"),
  callback = function()
    if vim.opt.cursorline and vim.bo.buftype == "" then
      vim.wo.cursorline = false
    end
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = Utils.create_augroup("cursor_normal"),
  callback = function()
    if vim.opt.cursorline and vim.bo.buftype == "" then
      vim.wo.cursorline = true
    end
  end,
})
