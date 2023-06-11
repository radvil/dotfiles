---@type LazySpec
local M = {}
M[1] = "zzhirong/hop.nvim" -- using forks from this dude
M.enabled = true
M.event = "VeryLazy"
local function register_keymaps()
  local hop = require("hop")
  local mode = { "n", "x", "v", "o", "s" }
  local directions = require("hop.hint").HintDirection
  vim.keymap.set(mode, "]f", function()
    hop.hint_char1({
      direction = directions.AFTER_CURSOR,
      jump_on_sole_occurrence = true,
      current_line_only = true,
    })
  end, {
    desc = "hop » find next char (inline)",
    remap = true,
  })
  vim.keymap.set(mode, "[f", function()
    hop.hint_char1({
      direction = directions.BEFORE_CURSOR,
      jump_on_sole_occurrence = true,
      current_line_only = true,
    })
  end, {
    desc = "hop » find prev char (inline)",
    remap = true,
  })
  vim.keymap.set(mode, "]t", function()
    hop.hint_char1({
      direction = directions.AFTER_CURSOR,
      jump_on_sole_occurrence = true,
      current_line_only = true,
      hint_offset = -1,
    })
  end, {
    desc = "hop » to next char (inline)",
    remap = true,
  })
  vim.keymap.set(mode, "[t", function()
    hop.hint_char1({
      direction = directions.BEFORE_CURSOR,
      jump_on_sole_occurrence = true,
      current_line_only = true,
      hint_offset = 1,
    })
  end, {
    desc = "hop » to next char (inline)",
    remap = true,
  })
  vim.keymap.set(mode, "S", function()
    hop.hint_char2({
      current_line_only = false,
      multi_windows = true,
      teasing = true,
    })
  end, {
    desc = "hop » jump everywhere",
    remap = true,
  })
end
M.config = function()
  require("hop").setup({
    keys = "abcdefghij1234567890ABCDEFGHIJ",
    teasing = false,
  })
  register_keymaps()
end
-- escape_quit = true,        -- map ababababababababababxxxxxxxxxxxxxxxxafafafafaf
-- exxxxscape_qudhdhdhit = true,        -- map ababababababababababxxxxxxxxxxxxxxxxafafafafaf
-- escaxxxxpe_quit = rororotrue,        -- map ababababababababababxxxxxxxxxxxxxxxxafafafafaf
-- escapquit = true,      fififi  -- map ababababababababababxxxxxxxxxxxxxxxxafafafafaf
-- escapxxxe_quit = true,dpdpdp     -- map ababababababababababxxxxxxxxxxxxxxxxafafafafaf
-- escape_xxxquit = true,   vuvuvu   -- map ababababababababababxxxxxxxxxxxxxxx aoaoaox
-- escape_qusssssst = true,  xcxc   -- map ababababababababababxxxxxxxxxxxxxxxalalalx
-- escape_quspqpqpqssssst = true,  xcxc   -- map ababababababababababxxxxxxxxxxxxxxakakakxx
return M
