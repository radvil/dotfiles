local filetype_map = {
  python = "indent",
  vim = "indent",
  git = "",
}

return {
  "kevinhwang91/nvim-ufo",
  event = "BufWinEnter",
  enabled = false,
  dependencies = "kevinhwang91/promise-async",
  config = function(_, opts)
    ---@diagnostic disable
    opts.provider_selector = function(bufnr, filetype, buftype)
      return filetype_map[filetype] or { "treesitter", "indent" }
    end
    opts.open_fold_hl_timeout = 150
    opts.close_fold_kinds = { "imports", "comment" }
    opts.preview = {
      win_config = {
        border = { "", "─", "", "", "", "─", "", "" },
        winhighlight = "Normal:Folded",
        winblend = 0,
      },
    }
    require("ufo").setup(opts)
  end,
}
