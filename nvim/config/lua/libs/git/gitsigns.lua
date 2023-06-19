---@type LazySpec
local M = {}
M[1] = "lewis6991/gitsigns.nvim"
M.enabled = true
M.event = "BufReadPre"

---@param bufnr number
---@param lhs string
---@param rhs function | string
---@param desc string
local map = function(bufnr, lhs, rhs, desc)
  return vim.keymap.set("n", lhs, rhs, {
    desc = "Gitsign » " .. desc,
    buffer = bufnr,
  })
end

M.opts = {
  current_line_blame_opts = {
    delay = 1000,
    virt_text_pos = "right_align",
    virt_text_priority = 100,
  },
  on_attach = function(buffer)
    local gs = require('gitsigns')
    map(buffer, "<leader>gu", function()
      gs.toggle_signs()
      gs.toggle_numhl()
      gs.toggle_linehl()
      gs.toggle_current_line_blame()
    end, "Toggle buffer status")
  end,
}

return M
