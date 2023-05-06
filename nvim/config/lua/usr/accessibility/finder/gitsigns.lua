---@desc git signs indicator
---@type LazySpec
local M = {}

M[1] = "lewis6991/gitsigns.nvim"

M.event = "BufReadPre"

-- TODO: change ugly icons
local signs = {
  add = { text = "▎" },
  change = { text = "▎" },
  delete = { text = "契" },
  topdelete = { text = "契" },
  changedelete = { text = "▎" },
  untracked = { text = "▎" },
}

M.opts = {
  signs = signs,
  on_attach = function(buffer)
    local function gs()
      return package.loaded.gitsigns
    end

    Map("n", "<C-z>g", function()
      gs().toggle_current_line_blame()
    end, { buffer = buffer, desc = "Toggle »  Git Blame Line" })

    Map("n", "<Leader>gd", function()
      gs().diffthis()
    end, { buffer = buffer, desc = " Git » Diff This" })
  end,
}

return M
