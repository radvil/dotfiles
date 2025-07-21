local notify = function(msg)
  return LazyVim.info(msg, { title = "gitsigns" })
end

return {
  "mrjones2014/legendary.nvim",
  -- priority = 9999,
  lazy = true,
  keys = function()
    return {
      {
        "<leader>/l",
        "<cmd>Legendary<cr>",
        desc = "Legendary",
      },
    }
  end,
  opts = {
    select_prompt = " Legendary ",
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
    if LazyVim.has("which-key.nvim") then
      opts.extensions.which_key = {
        auto_register = true,
      }
    end
    if LazyVim.has("gitsigns.nvim") then
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
