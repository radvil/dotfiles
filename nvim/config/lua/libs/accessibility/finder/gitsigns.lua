---@type LazySpec
local M = {}
M[1] = "lewis6991/gitsigns.nvim"
M.enabled = true
M.event = "BufReadPre"

-- -- TODO: change ugly icons
-- local signs = {
--   add = { text = "▎" },
--   change = { text = "▎" },
--   delete = { text = "契" },
--   topdelete = { text = "契" },
--   changedelete = { text = "▎" },
--   untracked = { text = "▎" },
-- }

M.opts = {
  -- signs = signs,
  on_attach = function(buffer)
    local function gs()
      return package.loaded.gitsigns
    end
    vim.keymap.set("n", "<c-z>g", function()
      gs().toggle_current_line_blame()
    end, { buffer = buffer, desc = "Toggle » git blame line" })
    vim.keymap.set("n", "<Leader>gd", function()
      gs().diffthis()
    end, { buffer = buffer, desc = "Git sign » diff current buffer" })
  end,
}

return M
