---@type LazySpec
local M = {}

local function next_ref()
  require("todo-comments").jump_next()
end

local function prev_ref()
  require("todo-comments").jump_prev()
end

M[1] = "folke/todo-comments.nvim"

M.event = "BufReadPost"

M.cmd = { "TodoTrouble", "TodoTelescope" }

M.config = true

M.keys = {
  {
    "]]",
    next_ref,
    desc = "[todo] Next ref",
    remap = true,
  },
  {
    "[[",
    prev_ref,
    desc = "[todo] Prev ref",
    remap = true,
  },
  {
    "<Leader>xt",
    "<Cmd>TodoTrouble<Cr>",
    desc = "Todo List",
  },
  {
    "<Leader>/t",
    "<Cmd>TodoTelescope<Cr>",
    desc = "Find » Todo(s)",
  },
}

return M
