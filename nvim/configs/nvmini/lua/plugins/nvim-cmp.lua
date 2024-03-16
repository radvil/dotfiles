return {
  "hrsh7th/nvim-cmp",
  optional = true,
  opts = {
    completion = { keyword_length = 1 },
    enabled = function()
      return vim.g.neo_autocomplete and vim.bo.buftype ~= "prompt"
    end,
    experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    },
  },
  init = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", {
      link = "Comment",
      default = true,
    })
  end,
}
