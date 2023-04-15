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
      copilot = "COPILOT",
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
M[1] = "hrsh7th/nvim-cmp" --4E2C-BC80
M.event = "InsertEnter"
M.dependencies = {
  "saadparwaiz1/cmp_luasnip",
  "windwp/nvim-autopairs",
  "L3MON4D3/LuaSnip",
  "zbirenbaum/copilot-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
}
M.opts = function()
  local luasnip = require("luasnip")
  local cmp = require("cmp")
  local mapping_confirm = cmp.mapping.confirm({ select = true })
  local mapping_confirm_copilot = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  })

  ---@type cmp.Config
  local opts = {
    completion = {
      completeopt = "menu,menuone",
    },
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
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = function(...)
        local entry = cmp.get_selected_entry()
        if entry and entry.source.name == "copilot" then
          return mapping_confirm_copilot(...)
        end
        return mapping_confirm(...)
      end,
      ["<S-CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
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
    sources = cmp.config.sources({
      { name = "copilot", group_index = 2 },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    }),
    formatting = formatting_style,
    -- experimental = {
    --   ghost_text = {
    --     hl_group = "LspCodeLens",
    --   },
    -- },
  }

  -- TODO: later set condition on rvim.env
  if true then
    opts.sorting = {
      priority_weight = 1,
      comparators = {
        require("copilot_cmp.comparators").prioritize,

        -- Below is the default comparitor list and order for nvim-cmp
        cmp.config.compare.offset,
        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    }
  end
  return opts
end

return M
