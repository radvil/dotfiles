-- NOTE: WE'LL WAIT FOR THE STABLE
-- THIS THING IS GONNA HELP US A LOT

local Config = require("neoverse.config")
for _, other in ipairs({ "aerial", "outline" }) do
  local extra = "neoverse.extras.editor." .. other
  if vim.tbl_contains(Config.json.data.extras, extra) then
    other = other:gsub("^%l", string.upper)
    Lonard.error({
      "**Trouble v3** includes support for document symbols.",
      ("You currently have the **%s** extra enabled."):format(other),
      "Please disable it in your config.",
    })
  end
end

return {
  {
    "folke/trouble.nvim",
    branch = "dev",
    keys = {
      { "<leader>xx", "<cmd>Truble diagnostics toggle<cr>", desc = "Diagnostics[Trouble] Workspace" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics[Trouble] Buffer" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Diagnostics[Trouble] Location List" },
      { "<leader>xQ", "<cmd>Touble qflist toggle<cr>", desc = "Diagnostics[Trouble] Quickfix List" },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Code[Trouble] Toggle Symbols",
      },
      {
        "<leader>cS",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "Code[Trouble] LSP references/definitions/...",
      },
    },
  },

  -- lualine integration
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local trouble = require("trouble")
      if not trouble.statusline then
        Lonard.error("You have enabled the **trouble-v3** extra,\nbut still need to update it with `:Lazy`")
        return
      end
      local symbols = trouble.statusline({
        format = "{kind_icon}{symbol.name:Normal}",
        mode = "lsp_document_symbols",
        filter = { range = true },
        title = false,
        groups = {},
      })
      table.insert(opts.sections.lualine_c, {
        symbols.get,
        cond = symbols.has,
      })
    end,
  },
}
