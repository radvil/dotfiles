local env = rvim.theme

---@LazySpec
local M = {}
M[1] = "nyoom-engineering/oxocarbon.nvim"
M.lazy = true
if env.colorscheme == "oxocarbon" then
  M.priority = 999
  M.lazy = false
  M.init = function()
    vim.opt.background = env.force_darkmode and "dark" or "light"
    vim.cmd.colorscheme("oxocarbon")
  end
end
return M
