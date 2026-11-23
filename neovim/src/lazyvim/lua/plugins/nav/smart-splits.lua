local M = {
  "mrjones2014/smart-splits.nvim",
  lazy = true,
}

M.dependencies = {
  {
    "smart-splits-nvim/backend-tmux",
    main = "smart-splits-backend-tmux",
  },
}

M.keys = function()
  -- TODO: better keymaps setup
  local ss = require("smart-splits")
  local Kmap = function(lhs, rhs, desc)
    return { lhs, rhs, mode = "n", desc = desc }
  end
  --stylua: ignore
  return {
    -- resize keymaps
    Kmap("<c-up>", ss.resize_up, "Resize window up"),
    Kmap("<c-down>", ss.resize_down, "Resize window down"),
    Kmap("<c-left>", function() ss.resize_left(6) end, "Resize window left"),
    Kmap("<c-right>", function() ss.resize_right(6) end, "Resize window right"),

    -- navigation keymaps
    Kmap("<c-j>", ss.move_cursor_down, "Go to lower window"),
    Kmap("<c-k>", ss.move_cursor_up, "Go to upper window"),
    Kmap("<c-h>", ss.move_cursor_left, "Go to left window"),
    Kmap("<c-l>", ss.move_cursor_right, "Go to right window"),
  }
end

M.opts = {
  mux = { backend = "smart-splits-backend-tmux" },
  move = { at_edge = "wrap" },
  ignored_buftypes = { "terminal", "prompt" },
  ignored_filetypes = {
    "TelescopeResults",
    "TelescopePrompt",
    "neo-tree-popup",
    "DressingInput",
    "flash_prompt",
    "cmp_menu",
    "neo-tree",
    "WhichKey",
    "Outline",
    "prompt",
    "lspinfo",
    "notify",
    "mason",
    "noice",
    "noice",
    "lazy",
    "oil",
  },
  log = {
    level = "info",
  },
  resize = {
    ignored_events = {
      "BufEnter",
      "WinEnter",
    },
  },
  swap = {
    move_cursor = true,
  },
}

return M
