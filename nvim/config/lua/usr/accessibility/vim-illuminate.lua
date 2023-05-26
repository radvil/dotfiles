---@type LazySpec
local M = {}
local function prev_ref()
  require("illuminate").goto_prev_reference(false)
end
local function next_ref()
  require("illuminate").goto_next_reference(false)
end
M[1] = "RRethy/vim-illuminate"
M.event = "BufReadPost"
M.enabled = true
M.keys = {
  {
    "<A-p>",
    prev_ref,
    desc = "Prev Reference",
    mode = { "n", "x", "v" }
  },
  {
    "<A-n>",
    next_ref,
    desc = "Next Reference",
    mode = { "n", "x", "v" }
  },
}
M.opts = {
  delay = 200,
  filetypes_denylist = require("opt.filetype").excludes,
}
M.config = function(_, opts)
  require("illuminate").configure(opts)
  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      if require("utils").buf_has_keymaps({ "<A-n>", "<A-p>" }) then
        pcall(vim.keymap.del, "n", "<A-n>", { buffer = true })
        pcall(vim.keymap.del, "n", "<A-p>", { buffer = true })
      end
    end,
  })
end
return M
