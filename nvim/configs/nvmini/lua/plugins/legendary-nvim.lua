return {
  "mrjones2014/legendary.nvim",
  lazy = true,
  keys = {
    {
      "<leader>q",
      "<cmd>Legendary<cr>",
      desc = "quick command/keymaps palette",
    },
  },
  opts = {
    select_prompt = " Quick command/keymaps ",
    include_legendary_cmds = false,
    include_builtin = true,
    extensions = {
      diffview = true,
      smart_splits = false,
      which_key = false,
      lazy_nvim = {
        auto_register = true,
      },
    },
  },
  config = function(_, opts)
    if require("neoverse.utils").lazy_has("which-key.nvim") then
      opts.extensions.which_key = {
        auto_register = true,
      }
    end
    require("legendary").setup(opts)
  end,
}
