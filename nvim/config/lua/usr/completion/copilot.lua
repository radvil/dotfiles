---@diagnostic disable: assign-type-mismatch
local env = rvim.completion.copilot
if not env.enabled then return {} end

---@type LazySpec[]
return {
  {
    "zbirenbaum/copilot.lua",
    enabled = env.enabled,
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = env.suggestion_enabled, },
      panel = { enabled = env.panel_enabled, },
    },
  },

  -- extends nvim cmp
  {
    "nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require("copilot_cmp")
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          require("lazyvim.util").on_attach(function(client)
            if client.name == "copilot" then
              copilot_cmp._on_insert_enter({})
            end
          end)
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      table.insert(opts.sources, 0, { name = "copilot", group_index = 2 })
      opts.sorting = {
        priority_weight = 1,
        comparators = {
          require("copilot_cmp.comparators").prioritize,
          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }
    end,
  },
}
