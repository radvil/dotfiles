local biome_prior = { { "biome", "prettier" } }
local prettier_prior = { { "prettier", "biome" } }

return {
  {
    "mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "biome")
    end,
  },

  {
    "conform.nvim",
    optional = true,
    ---@class ConformOpts
    opts = {
      -- if both biome and prettier executable is not available
      lsp_fallback = true,
      formatters = {
        biome = {
          ---NOTE: only use biome if config file exists
          condition = function(ctx)
            return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
      formatters_by_ft = {
        javascript = biome_prior,
        typescript = biome_prior,
        javascriptreact = biome_prior,
        typescriptreact = biome_prior,
        json = biome_prior,
        jsonc = biome_prior,
        vue = biome_prior,

        yaml = prettier_prior,
        graphql = prettier_prior,
        css = prettier_prior,
        scss = prettier_prior,
        less = prettier_prior,
        html = prettier_prior,
        markdown = prettier_prior,
        handlebars = prettier_prior,
        ["markdown.mdx"] = prettier_prior,
      },
    },
  },
}
