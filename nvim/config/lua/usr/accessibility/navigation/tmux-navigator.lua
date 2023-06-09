---@type LazySpec
local M = {}
M[1] = "christoomey/vim-tmux-navigator"
M.enabled = os.getenv("TMUX") ~= nil
M.init = function()
  vim.cmd [[let g:tmux_navigator_no_mappings = 1]]
  Map("n", "<c-h>", ":TmuxNavigateLeft<cr>", { desc = "Window/Tmux » navigate left" })
  Map("n", "<c-j>", ":TmuxNavigateDown<cr>", { desc = "Window/Tmux » navigate down" })
  Map("n", "<c-k>", ":TmuxNavigateUp<cr>", { desc = "Window/Tmux » navigate up" })
  Map("n", "<c-l>", ":TmuxNavigateRight<cr>", { desc = "Window/Tmux » navigate right" })
end
return M
