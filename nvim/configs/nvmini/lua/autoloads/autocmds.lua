local Utils = require("neoverse.utils")

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
