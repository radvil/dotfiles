if not pcall(require, "Comment") then
  return
end

require("Comment").setup({
  opleader = {
    line = "gc",
    block = "gb",
  },

  mappings = {
    -- operator-pending mapping
    -- Includes:
    --  `gcc`               -> line-comment  the current line
    --  `gcb`               -> block-comment the current line
    --  `gc[count]{motion}` -> line-comment  the region contained in {motion}
    --  `gb[count]{motion}` -> block-comment the region contained in {motion}
    basic = true,

    -- extra mapping
    -- Includes `gco`, `gcO`, `gcA`
    extra = true,
  },

  -- LHS of toggle mapping in NORMAL + VISUAL mode
  toggler = {
    line = "gcc",
    block = "gbc",
  },
})

local comment_ft = require("Comment.ft")
comment_ft.set("lua", { "--%s", "--[[%s]]" })
