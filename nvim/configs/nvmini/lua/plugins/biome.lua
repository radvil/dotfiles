local with_fallback = { { "biome", "prettier" } }

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
            return vim.fs.find({
              "biome.json",
              "biome.jsonc",
            }, { path = ctx.filename, upward = true })[1]
          end
        },
      },
      formatters_by_ft = {
        javascript = with_fallback,
        typescript = with_fallback,
        javascriptreact = with_fallback,
        typescriptreact = with_fallback,
        json = with_fallback,
        jsonc = with_fallback,
        vue = with_fallback,
        css = with_fallback,
        scss = with_fallback,
        less = with_fallback,
        html = with_fallback,
        yaml = with_fallback,
        graphql = with_fallback,
        markdown = with_fallback,
        handlebars = with_fallback,
        ["markdown.mdx"] = with_fallback,
      }
    }
  },
}
