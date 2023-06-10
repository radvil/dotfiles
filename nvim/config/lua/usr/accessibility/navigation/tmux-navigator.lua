---@type LazySpec
local M = {}
M[1] = "christoomey/vim-tmux-navigator"
M.enabled = os.getenv("TMUX") ~= nil
M.init = function()
  vim.cmd([[let g:tmux_navigator_no_mappings = 1]])
  rnv.api.map("n", "<c-h>", ":TmuxNavigateLeft<cr>", { desc = "Window/Tmux » navigate left" })
  rnv.api.map("n", "<c-j>", ":TmuxNavigateDown<cr>", { desc = "Window/Tmux » navigate down" })
  rnv.api.map("n", "<c-k>", ":TmuxNavigateUp<cr>", { desc = "Window/Tmux » navigate up" })
  rnv.api.map("n", "<c-l>", ":TmuxNavigateRight<cr>", { desc = "Window/Tmux » navigate right" })
end
return M
