---@type LazySpec
local M = {}
M[1] = "christoomey/vim-tmux-navigator"
M.enabled = os.getenv("TMUX") ~= nil
return M
