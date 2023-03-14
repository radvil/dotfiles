local env = rvim.theme
local transparent = env.transbg and env.force_darkmode

---@type LazySpec[]
local M = {}
M[1] = "EdenEast/nightfox.nvim"
M.lazy = true
M.opts = {
  options = {
    transparent = transparent,
    compile_path = rvim.path.cache .. "/nightfox",
    compile_file_suffix = "_compiled",
    terminal_colors = true,
    dim_inactive = true,
    inverse = {
      match_paren = true,
      visual = false,
      search = true,
    },
    styles = {
      comments = "italic",
    },
  },
}
if env.colorscheme == "nightfox" then
  M.priority = 999
  M.lazy = false
  M.init = function()
    vim.cmd("colorscheme " .. env.variant)
  end
end
return M
