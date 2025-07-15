---@diagnostic disable: missing-parameter, missing-fields
local open_with_trouble = function(...)
  require("trouble.sources.telescope").open(...)
end

---@type LazySpec[]
return {
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = function()
      return {
        {
          "<leader>xb",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "[b]uffer diagnosti[x]",
        },
        {
          "<leader>xw",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "[w]orkspace diagnosti[x]",
        },
        {
          "<leader>xl",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "diagnosti[x] [l]oclist",
        },
        {
          "<leader>xq",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "diagnosti[x] [q]uickfix",
        },
        -- TODO: check possible duplicated with Outline.nvim
        {
          "<leader>cS",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP references/definitions/... (Trouble)",
        },
        {
          "[q",
          function()
            if require("trouble").is_open() then
              require("trouble").prev({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cprev)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end,
          desc = "Previous Trouble/Quickfix Item",
        },
        {
          "]q",
          function()
            if require("trouble").is_open() then
              require("trouble").next({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cnext)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end,
          desc = "Next Trouble/Quickfix Item",
        },
      }
    end,
  },

  -- extends telescope actions
  {
    "telescope.nvim",
    optional = true,
    opts = {
      defaults = {
        mappings = {
          ["n"] = { ["<a-x>"] = open_with_trouble },
          ["i"] = { ["<a-x>"] = open_with_trouble },
        },
      },
    },
  },
}
