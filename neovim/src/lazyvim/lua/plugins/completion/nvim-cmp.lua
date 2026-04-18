return {
  "hrsh7th/nvim-cmp",
  optional = true,
  opts = function(_, opts)
    -- opts.mapping["<C-CR>"] = nil
    -- opts.mapping["<S-CR>"] = nil
    -- opts.mapping["<CR>"] = nil

    local wd = require("cmp").config.window
    opts.window = {
      documentation = wd.bordered(),
      completion = wd.bordered(),
    }
  end,
}
