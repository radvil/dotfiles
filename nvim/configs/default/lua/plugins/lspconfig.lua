---@diagnostic disable: duplicate-set-field

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
    -- TODO: `type_definitions` conflicted with yank to clipboard
    keys[#keys + 1] = { "gy", false }
    keys[#keys + 1] = { "<c-k>", false, mode = "i" }
    keys[#keys + 1] = { "<leader>cc", false }
    keys[#keys + 1] = { "<leader>cC", false }
    keys[#keys + 1] = { "]]", false }
    keys[#keys + 1] = { "[[", false }
    keys[#keys + 1] = {
      "g<c-v>",
      function()
        require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
      end,
      desc = "Go to Definition (vsplit)",
      has = "definition",
    }
    keys[#keys + 1] = {
      "g<c-x>",
      function()
        require("telescope.builtin").lsp_definitions({ jump_type = "split" })
      end,
      desc = "Go to Definition (split)",
      has = "definition",
    }
    keys[#keys + 1] = {
      "g<c-t>",
      function()
        require("telescope.builtin").lsp_definitions({ jump_type = "tab drop" })
      end,
      desc = "Go to Definition (tab drop)",
      has = "definition",
    }
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

    keys[#keys + 1] = {
      "<a-n>",
      function()
        LazyVim.lsp.words.jump(vim.v.count1)
      end,
      has = "documentHighlight",
      desc = "Next Reference",
      mode = { "n", "x", "o" },
    }

    keys[#keys + 1] = {
      "<a-p>",
      function()
        LazyVim.lsp.words.jump(-vim.v.count1)
      end,
      has = "documentHighlight",
      desc = "Next Reference",
      mode = { "n", "x", "o" },
    }
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
      -- html = { },
      cssls = {},
      emmet_language_server = {},
    },
  },
}
