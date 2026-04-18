---@diagnostic disable: redundant-parameter

return {
  "hrsh7th/nvim-cmp",
  optional = true,
  dependencies = {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    config = function()
      local cmp = require("cmp")
      require("cmp").setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          {
            name = "cmdline",
            keyword_length = 2,
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}
