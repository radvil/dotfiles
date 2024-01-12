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
    local Utils = require("neoverse.utils")
    if Utils.lazy_has("which-key.nvim") then
      opts.extensions.which_key = {
        auto_register = true,
      }
    end
    if Utils.lazy_has("gitsigns.nvim") then
      vim.list_extend(opts.keymaps, {
        {
          "<leader>gr",
          function()
            require("gitsigns").refresh()
            vim.schedule(function()
              require("neoverse.utils").info("refreshed", { title = "gitsigns" })
            end)
          end,
          description = "gitsigns » refresh view",
        },
        {
          "<leader>gun",
          function()
            require("gitsigns").toggle_numhl()
            vim.schedule(function()
              require("neoverse.utils").info("numbers toggled", { title = "gitsigns" })
            end)
          end,
          description = "gitsigns » toggle numbers",
        },
        {
          "<leader>guu",
          function()
            require("gitsigns").toggle_signs()
            vim.schedule(function()
              require("neoverse.utils").info("signs toggled", { title = "gitsigns" })
            end)
          end,
          description = "gitsigns » toggle signs",
        },
        {
          "<leader>gud",
          function()
            require("gitsigns").toggle_word_diff()
            vim.schedule(function()
              require("neoverse.utils").info("word diff toggled", { title = "gitsigns" })
            end)
          end,
          description = "gitsigns » toggle word diff",
        },
        {
          "<leader>gub",
          function()
            require("gitsigns").toggle_current_line_blame()
            vim.schedule(function()
              require("neoverse.utils").info("line blame toggled", { title = "gitsigns" })
            end)
          end,
          description = "gitsigns » toggle current line blame",
        },
      })
    end
    require("legendary").setup(opts)
  end,
}
