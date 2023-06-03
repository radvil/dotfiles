---@type LazySpec
local M = {}
M[1] = "hrsh7th/nvim-cmp"

---@diagnostic disable-next-line: assign-type-mismatch
M.version = false -- last release is way too old
M.event = "InsertEnter"
M.enabled = rvim.completion.enabled
M.dependencies = {
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
}

M.init = function()
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#EC5F67" })
end

M.opts = function()
  local luasnip = require("luasnip")
  local cmp = require("cmp")

  ---@type cmp.Config
  return {
    completion = {
      completeopt = "menu,menuone",
      -- keyword_length = 2,
    },
    window = {
      documentation = cmp.config.window.bordered(),
      completion = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip", },
      { name = "copilot", },
      { name = "buffer",  keyword_length = 3 },
      { name = "path", },
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind_icons = require("media.icons").KindIcons
        local item_kind = vim_item.kind
        local sources = {
          nvim_lsp = item_kind,
          luasnip = " Snippet",
          copilot = " Copilot",
          buffer = " Buffer",
          path = " Path",
        }
        vim_item.kind = kind_icons[item_kind]
        vim_item.menu = sources[entry.source.name]
        return vim_item
      end,
    },
    mapping = {
      ["<c-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<c-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<c-u>"] = cmp.mapping.scroll_docs(-4),
      ["<c-d>"] = cmp.mapping.scroll_docs(4),
      ["<c-space>"] = cmp.mapping.complete(),
      ["<c-e>"] = cmp.mapping.abort(),
      ["<cr>"] = cmp.mapping.confirm({ select = true }),
      ["<c-o>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    },
  }
end

return M
