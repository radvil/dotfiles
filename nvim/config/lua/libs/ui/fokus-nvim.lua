---@type LazySpec
local M = {}
M[1] = "radvil/fokus.nvim"
M.enabled = true
M.dev = rnv.opt.dev
M.event = "BufReadPre"
M.dependencies = { "folke/twilight.nvim" }
M.keys = {
  {
    "<Leader>wu",
    vim.cmd.FokusToggle,
    desc = "Window » Toggle fokus mode",
  },
}
M.config = function()
  require("fokus").setup({
    exclude_filetypes = {
      unpack(require("opt.filetype").excludes),
      unpack(require("opt.filetype").popups)
    },
    notify = { enabled = true },
    hooks = {},
  })
end
return M
