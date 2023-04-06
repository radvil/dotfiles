---@desc auto completion brigde
---@type LazySpec
local M = {}
M[1] = "hrsh7th/nvim-cmp"
M.event = "InsertEnter"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.dependencies = {
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
}

M.opts = function()
  local luasnip = require("luasnip")
  local nvim_cmp = require("cmp")
  local cmap = nvim_cmp.mapping
  ---@type cmp.Config
  return {
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    preselect = nvim_cmp.PreselectMode.Item,
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
    window = {
      completion = nvim_cmp.config.window.bordered(),
      documentation = nvim_cmp.config.window.bordered(),
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmap.preset.insert({
      ["<CR>"] = cmap.confirm({ select = true }),
      ["<C-Space>"] = cmap.complete({}),
      ["<C-u>"] = cmap.scroll_docs(-4),
      ["<C-d>"] = cmap.scroll_docs(4),
      ["<C-e>"] = cmap.abort(),
      ["<C-x>"] = cmap.close(),
      ["<C-n>"] = cmap(function(fallback)
        if nvim_cmp.visible() then
          nvim_cmp.select_next_item({
            behavior = nvim_cmp.SelectBehavior.Insert,
          })
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          nvim_cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-p>"] = cmap(function(fallback)
        if nvim_cmp.visible() then
          nvim_cmp.select_prev_item({
            behavior = nvim_cmp.SelectBehavior.Insert,
          })
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = nvim_cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip",  priority = 750 },
      { name = "buffer",   priority = 500 },
      { name = "path",     priority = 250 },
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind_icons = require("media.icons").KindIcons
        local item_kind = vim_item.kind
        local sources = {
          nvim_lsp = item_kind,
          luasnip = " SNIP",
          buffer = " BUFF",
          path = " PATH",
        }
        vim_item.kind = kind_icons[item_kind]
        vim_item.menu = sources[entry.source.name]
        return vim_item
      end,
    },
  }
end

M.init = function()
  -- If you want insert `(` after select function or method item
  require("cmp").event:on("confirm_done", function()
    require "nvim-autopairs.completion.cmp".on_confirm_done()
  end)
end

return M
