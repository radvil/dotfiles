return {
  "neovim/nvim-lspconfig",
  opts = {
    -- options for vim.diagnostic.config()
    ---@type vim.diagnostic.Opts
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- prefix = "icons",
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
        },
      },
    },
    -- You also will need to properly configure your LSP server to
    -- provide the inlay hints.
    inlay_hints = {
      enabled = false,
      exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
    },
    -- You also will need to properly configure your LSP server to
    -- provide the code lenses.
    codelens = {
      enabled = false,
    },
    -- You also will need to properly configure your LSP server to
    -- provide the folds.
    folds = {
      enabled = true,
    },
    -- options for vim.lsp.buf.format
    -- `bufnr` and `filter` is handled by the LazyVim formatter,
    -- but can be also overridden when specified
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
  },
}
