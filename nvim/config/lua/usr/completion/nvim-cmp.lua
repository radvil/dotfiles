local env = function()
  return rvim.completion
end

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
      luasnip = " Snippet",
      copilot = " Copilot",
      buffer = " Buffer",
      path = " Path",
    }
    vim_item.kind = kind_icons[item_kind]
    vim_item.menu = sources[entry.source.name]
    return vim_item
  end,
}

local sources = {
  { name = "copilot",  group_index = 2 },
  { name = "nvim_lsp", group_index = 2 },
  { name = "luasnip",  group_index = 2 },
  { name = "buffer",   group_index = 2 },
  { name = "path",     group_index = 2 },
}

---@type LazySpec
local M = {}
M[1] = "hrsh7th/nvim-cmp"
M.event = "InsertEnter"
M.enabled = env().enabled
M.dependencies = {
  "saadparwaiz1/cmp_luasnip",
  "windwp/nvim-autopairs",
  "L3MON4D3/LuaSnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
}
if env().copilot.enabled then
  table.insert(sources, #sources - 2, { name = "copilot" })
  ---@diagnostic disable-next-line: param-type-mismatch
  table.insert(M.dependencies, "zbirenbaum/copilot-cmp")
end
M.init = function()
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#EC5F67" })
end
M.opts = function()
  local luasnip = require("luasnip")
  local cmp = require("cmp")
  ---@type cmp.Config
  local opts = {
    completion = { completeopt = "menu,menuone", },
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
      ["<C-x>"] = cmp.mapping.abort(),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
    sources = cmp.config.sources(sources),
    formatting = formatting_style,
  }

  if not env().copilot.enabled then
    opts.experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    }
  else
    opts.window = {
      documentation = cmp.config.window.bordered(),
      completion = cmp.config.window.bordered(),
    }
  end
  return opts
end
M.config = function(_, opts)
  ---ensure mapping don't exist
  vim.keymap.set("i", "<A-n>", "<Nop>")
  require("cmp").setup(opts)
end

return M
