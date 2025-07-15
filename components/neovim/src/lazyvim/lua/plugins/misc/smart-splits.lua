local M = {
  "mrjones2014/smart-splits.nvim",
  lazy = true,
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

    -- window operation
    Kmap("<leader>w<cr>", ss.start_resize_mode, "Start window resizing"),
  }
end

M.opts = {
  log_level = "info",
  ignored_buftypes = { "terminal", "prompt" },
  cursor_follows_swapped_bufs = true,
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
  resize_mode = {
    quit_key = "q",
    resize_keys = { "h", "j", "k", "l" },
    silent = true,
    hooks = {
      on_enter = function()
        LazyVim.info("Resizing start. Press <q> to exit!", { title = "Window" })
      end,
      on_leave = function()
        LazyVim.warn("Resizing stopped!", { title = "Window" })
      end,
    },
  },
  ignored_events = {
    "BufEnter",
    "WinEnter",
  },
}

return M
