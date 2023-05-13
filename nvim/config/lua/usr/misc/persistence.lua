---@type LazySpec
local M = {}
M[1] = "folke/persistence.nvim"
M.event = "BufReadPre"
M.opts = {
  options = {
    "buffers",
    "tabpages",
    "winsize",
    "curdir",
    "help",
  },
}
local function restore_session()
  require("persistence").load()
end

local function restore_last_session()
  require("persistence").load({ last = true })
end

local function stop_session_saving()
  require("persistence").stop()
end
M.keys = {
  {
    "<Leader>Sr",
    restore_session,
    desc = "Restore [CWD]",
  },
  {
    "<Leader>Sl",
    restore_last_session,
    desc = "Restore Last",
  },
  {
    "<C-z>S",
    stop_session_saving,
    desc = "Toggle » Session Persistence",
  },
}
return M
