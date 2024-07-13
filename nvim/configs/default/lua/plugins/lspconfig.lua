---@diagnostic disable: duplicate-set-field

LazyVim.lsp.words.enabled = false

return {
  "neovim/nvim-lspconfig",
  init = function()
    local border = vim.g.neo_winborder
    require("lspconfig.ui.windows").default_options.border = border

    if not LazyVim.has("noice.nvim") then
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
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
    vim.list_extend(keys, {
      { "<c-k>", false, mode = "i" },
      { "<leader>cc", false },
      { "<leader>cC", false },
      { "gy", false },
    })
  end,

  opts = {
    diagnostics = {
      float = { border = vim.g.neo_winborder },
      virtual_text = {
        prefix = "icons",
      },
    },
    inlay_hints = {
      enabled = false,
    },
    codelens = {
      enabled = false,
    },
    servers = {
      bashls = {},
      html = {},
      cssls = {},
      emmet_language_server = {
        filetypes = { "typescript", "html" },
      },
    },
  },
}
