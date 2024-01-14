-- local Utils = require("neoverse.utils")
-- local palette = require("neoverse.config").palette

-- vim.cmd([[:amenu 10.90 mousemenu.Select\ all <cmd>normal ggVG<CR>]])
-- vim.cmd([[:amenu 10.100 mousemenu.Goto\ definitions <cmd>Telescope lsp_definitions<CR>]])
-- vim.cmd([[:amenu 10.110 mousemenu.Goto\ references <cmd>Telescope lsp_references<CR>]])
-- vim.cmd([[:amenu 10.110 mousemenu.Goto\ implementations <cmd>Telescope lsp_implementations<CR>]])

if vim.opt.cursorline then
  vim.opt.guicursor = ""

  -- TODO: do this better
  -- vim.api.nvim_create_autocmd("InsertEnter", {
  --   group = Utils.create_augroup("cursor_insert"),
  --   callback = function()
  --     vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
  --   end,
  -- })
  --
  -- vim.api.nvim_create_autocmd("InsertLeave", {
  --   group = Utils.create_augroup("cursor_normal"),
  --   callback = function()
  --     vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.dark2 })
  --   end,
  -- })
end
