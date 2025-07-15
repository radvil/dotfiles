return {
  "stevearc/stickybuf.nvim",
  event = "BufAdd",
  opts = {
    neo_excludes = {
      "Outline",
    },
  },
  config = function(_, opts)
    require("stickybuf").setup({
      get_auto_pin = function(bufnr)
        local filetype = vim.bo[bufnr].filetype
        if vim.tbl_contains(opts.neo_excludes, filetype) then
          return "filetype"
        end
      end,
    })
  end,
}
