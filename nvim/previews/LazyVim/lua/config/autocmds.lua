-- autocmds are automatically loaded on the verylazy event
-- default autocmds that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/autocmds.lua

-- close popups using <a-space>
vim.api.nvim_create_autocmd("FileType", {
  pattern = require("common.filetypes").popups,
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("", "<a-space>", ":close<cr>", {
      buffer = event.buf,
      silent = true,
    })
  end,
})
