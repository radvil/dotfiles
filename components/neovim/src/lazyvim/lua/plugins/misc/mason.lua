return {
  "mason.nvim",
  keys = function()
    return {
      {
        "<leader>mM",
        vim.cmd.Mason,
        desc = "[M]ason",
      },
    }
  end,
  opts = {
    ui = {
      border = vim.g.neo_winborder,
    },
  },
}
