return {
  "hrsh7th/nvim-cmp",
  optional = true,
  opts = function(_, opts)
    opts.mapping["<C-CR>"] = nil
    opts.mapping["<S-CR>"] = nil
    opts.mapping["<CR>"] = nil
    if vim.g.neo_transparent then
      local cmp = require("cmp")
      opts.window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
      }
    end
  end,
}
