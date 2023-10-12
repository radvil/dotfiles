return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  opts = function(_, opts)
    opts.extensions = { "lazy" }
  end,
}
