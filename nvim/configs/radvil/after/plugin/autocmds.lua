require("rad.core.utils").log("Loading autocommands...")

--Check if any buffers were changed outside of Vim.
vim.api.nvim_create_autocmd({
  "FocusGained",
  "TermClose",
  "TermLeave",
}, { command = "checktime" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 99 })
  end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close with <q>, escape with <A-Space>
--vim.api.nvim_create_autocmd("FileType", {
--  pattern = require("minimal.filetype").Windows,
--  callback = function(event)
--    vim.bo[event.buf].buflisted = false
--    vim.wo.foldcolumn = "0"
--    vim.keymap.set("n", "q", ":close<cr>", {
--      buffer = event.buf,
--      silent = true,
--    })
--  end,
--})

-- enable line wrap and spelling on gitcommit and md filetye
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

