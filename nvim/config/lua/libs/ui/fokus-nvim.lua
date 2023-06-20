---@type LazySpec
local M = {}
M[1] = "radvil/fokus.nvim"
M.enabled = true
M.dev = rnv.opt.dev
M.event = "BufReadPre"
M.dependencies = "folke/twilight.nvim"

M.keys = {
  {
    "<Leader>wf",
    vim.cmd.FokusToggle,
    desc = "Window » Fokus toggle",
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
  -- if rnv.opt.transbg then
  vim.cmd.FokusToggle()
  -- end
end

return M
