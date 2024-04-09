return {
  "neovim/nvim-lspconfig",
  init = function()
    if not LazyVim.has("noice.nvim") then
      local border = vim.g.neo_winborder
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      --- https://github.com/neovim/neovim/issues/20457#issuecomment-1266782345
      vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
        config = config or {}
        config.border = border
        config.focus_id = ctx.method
        if not (result and result.contents) then
          return
        end
        local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
        -- markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
        if vim.tbl_isempty(markdown_lines) then
          return
        end
        return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
      end
    end

    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<c-k>", false }
    keys[#keys + 1] = { "<leader>cc", false }
    keys[#keys + 1] = { "<leader>cC", false }
    keys[#keys + 1] = {
      "<a-k>",
      vim.lsp.buf.signature_help,
      mode = "i",
      desc = "Signature Help",
      has = "signatureHelp",
    }
    keys[#keys + 1] = {
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
    }
  end,

  opts = {
    servers = {
      bashls = {},
      html = {
        -- mason = false,
        -- cmd = {
        --   os.getenv("HOME") .. "/.bun/bin/vscode-html-language-server",
        --   "--stdio",
        -- },
      },
      cssls = {
        -- mason = false,
        -- cmd = {
        --   os.getenv("HOME") .. "/.bun/bin/vscode-css-language-server",
        --   "--stdio",
        -- },
      },
      emmet_language_server = {
        -- mason = false,
        -- cmd = {
        --   os.getenv("HOME") .. "/.bun/bin/emmet-language-server",
        --   "--stdio",
        -- },
      },
    },
  },
}
