local env = rvim.theme
local transbg = env.force_darkmode and env.transbg

---@type LazySpec
local M = {}
M[1] = "uloco/bluloco.nvim"
M.dependencies = "rktjmp/lush.nvim"
-- M.lazy = true
M.config = function()
  local opts = {
    ---@type "auto" | "dark" | "light"
    style = env.force_darkmode and "dark" or "light",
    ---bluloco colors are enabled in gui terminals per default.
    terminal = vim.fn.has("gui_running") == 1,
    transparent = transbg,
    guicursor = true,
    italics = false,
  }
  require("bluloco").setup(opts)
end
if env.colorscheme == "bluloco" then
  M.priority = 999
  M.lazy = false
  M.init = function()
    vim.cmd("colorscheme bluloco")
  end
end
return M
