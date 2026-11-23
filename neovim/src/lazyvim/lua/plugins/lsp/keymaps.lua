return {
  "neovim/nvim-lspconfig",
  optional = true,
  opts = {
    servers = {
      ["*"] = {
        keys = {
          { "<c-k>", false, mode = "i" },
          { "<leader>cc", false },
          { "<leader>cC", false },
          { "gy", false },

          -- stylua: ignore start
          { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", has = "definition" },
          { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
          { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
          { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
          { "<leader>ss", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Symbols", has = "documentSymbol" },
          { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
          { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming", has = "callHierarchy/incomingCalls" },
          { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing", has = "callHierarchy/outgoingCalls" },
          -- stylua: ignore end

          {
            "g<c-v>",
            function()
              Snacks.picker.lsp_definitions({ confirm = "edit_vsplit" })
            end,
            desc = "Go to Definition (vsplit)",
            has = "definition",
          },
          {
            "g<c-x>",
            function()
              Snacks.picker.lsp_definitions({ confirm = "edit_split" })
            end,
            desc = "Go to Definition (split)",
            has = "definition",
          },
          {
            "g<c-t>",
            function()
              Snacks.picker.lsp_definitions({ confirm = "tab" })
            end,
            desc = "Go to Definition (tab drop)",
            has = "definition",
          },
          {
            "<a-k>",
            vim.lsp.buf.signature_help,
            mode = "i",
            desc = "Signature Help",
            has = "signatureHelp",
          },
          {
            "K",
            function()
              local ufo = LazyVim.has("nvim.ufo")
              if ufo then
                return require("ufo").peekFoldedLinesUnderCursor() or vim.lsp.buf.hover()
              else
                return vim.lsp.buf.hover()
              end
            end,
            desc = "Hover",
            has = "hover",
          },
        },
      },
    },
  },
}
