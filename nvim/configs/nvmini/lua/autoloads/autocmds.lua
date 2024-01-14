local Utils = require("neoverse.utils")

-- vim.cmd([[:amenu 10.90 mousemenu.Select\ all <cmd>normal ggVG<CR>]])
-- vim.cmd([[:amenu 10.100 mousemenu.Goto\ definitions <cmd>Telescope lsp_definitions<CR>]])
-- vim.cmd([[:amenu 10.110 mousemenu.Goto\ references <cmd>Telescope lsp_references<CR>]])
-- vim.cmd([[:amenu 10.110 mousemenu.Goto\ implementations <cmd>Telescope lsp_implementations<CR>]])

if vim.opt.cursorline then
  vim.opt.guicursor = ""

  vim.api.nvim_create_autocmd("InsertEnter", {
    group = Utils.create_augroup("cursor_insert"),
    callback = function()
      vim.wo.cursorline = false
    end,
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    group = Utils.create_augroup("cursor_normal"),
    callback = function()
      vim.wo.cursorline = true
    end,
  })
end
