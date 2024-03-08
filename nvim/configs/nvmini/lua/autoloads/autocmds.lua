local Utils = require("neoverse.utils")

-- vim.api.nvim_create_autocmd({
--   "InsertEnter", --[[ "WinLeave"  ]]
-- }, {
--   group = Utils.create_augroup("cursor_insert"),
--   callback = function()
--     if vim.opt.cursorline and vim.bo.buftype == "" then
--       vim.wo.cursorline = false
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({
--   "InsertLeave", --[[ "WinEnter"  ]]
-- }, {
--   group = Utils.create_augroup("cursor_normal"),
--   callback = function()
--     if vim.opt.cursorline and vim.bo.buftype == "" then
--       vim.wo.cursorline = true
--     end
--   end,
-- })

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = Utils.create_augroup("leaving_cwd"),
  callback = function()
    if vim.bo.buftype == "" then
      if Utils.root() ~= vim.loop.cwd() then
        Utils.warn("Leaving [cwd] to " .. Utils.root(), { title = "Warning" })
      end
    end
  end,
})
