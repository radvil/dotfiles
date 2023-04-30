---@type LazySpec
local M = {}
local env = function()
  return rvim.completion.copilot
end
M[1] = "zbirenbaum/copilot.lua"
M.enabled = env().enabled
M.cmd = "Copilot"
M.build = ":Copilot auth"
M.opts = {
  suggestion = {
    enabled = env().suggestion_enabled,
  },
  panel = {
    enabled = env().panel_enabled,
  },
}
M.dependencies = {
  "zbirenbaum/copilot-cmp",
  dependencies = "zbirenbaum/copilot.lua",
  opts = {},
  config = function(_, opts)
    local copilot_cmp = require("copilot_cmp")
    copilot_cmp.setup(opts)
    -- attach cmp source whenever copilot attaches
    -- fixes lazy-loading issues with the copilot cmp source
    require("utils").on_attach(function(client)
      if client.name == "copilot" then
        copilot_cmp._on_insert_enter()
      end
    end)
  end,
}
return M
