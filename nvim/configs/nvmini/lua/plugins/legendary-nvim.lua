local notify = function(msg)
  return Lonard.info(msg, { title = "gitsigns" })
end

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
    keymaps = {},
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
    if Lonard.lazy_has("which-key.nvim") then
      opts.extensions.which_key = {
        auto_register = true,
      }
    end
    if Lonard.lazy_has("gitsigns.nvim") then
      vim.list_extend(opts.keymaps, {
        {
          "<leader>gr",
          function()
            require("gitsigns").refresh()
            notify("view refreshed")
          end,
          description = "gitsigns » refresh view",
        },
        {
          "<leader>gun",
          function()
            require("gitsigns").toggle_numhl()
            notify("numbers toggled")
          end,
          description = "gitsigns » toggle numbers",
        },
        {
          "<leader>guu",
          function()
            require("gitsigns").toggle_signs()
            notify("signs toggled")
          end,
          description = "gitsigns » toggle signs",
        },
        {
          "<leader>gud",
          function()
            require("gitsigns").toggle_word_diff()
            notify("word diff toggled")
          end,
          description = "gitsigns » toggle word diff",
        },
        {
          "<leader>gub",
          function()
            require("gitsigns").toggle_current_line_blame()
            notify("line blame toggled")
          end,
          description = "gitsigns » toggle current line blame",
        },
      })
    end
    require("legendary").setup(opts)
  end,
}
