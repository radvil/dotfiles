local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local formatting_style = {
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
}

---@type LazySpec
local M = {}
M[1] = "hrsh7th/nvim-cmp"
M.event = "InsertEnter"
M.dependencies = {
  "L3MON4D3/LuaSnip",      -- TODO: refactor config
  "windwp/nvim-autopairs", -- TODO: refactor config
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
}
M.opts = function()
  local luasnip = require("luasnip")
  local cmp = require("cmp")
  ---@type cmp.Config
  return {
    completion = {
      completeopt = "menu,menuone",
    },
    -- experimental = {
    --   ghost_text = {
    --     hl_group = "LspCodeLens",
    --   },
    -- },
    window = {
      documentation = cmp.config.window.bordered(),
      completion = cmp.config.window.bordered(),
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    formatting = formatting_style,
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip",  priority = 750 },
      { name = "buffer",   priority = 500 },
      { name = "path",     priority = 250 },
    }),
  }
end

return M
