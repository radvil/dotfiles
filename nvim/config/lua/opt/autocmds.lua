rnv.api.log("Loading autocommands...", "opt.autocmds")

-- Check if we need to reload the file when it changed
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
vim.api.nvim_create_autocmd("FileType", {
  pattern = require("opt.filetype").excludes,
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", ":close<cr>", {
      buffer = event.buf,
      silent = true,
    })
  end,
})

-- -- close popups using <A-Space>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = require("opt.filetype").popups,
--   callback = function(event)
--     vim.bo[event.buf].buflisted = false
--     vim.keymap.set("", "<A-Space>", ":close<cr>", {
--       buffer = event.buf,
--       silent = true,
--     })
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
