local env = function()
  return rvim.completion
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
  { name = "nvim_lsp", group_index = 1 },
  { name = "luasnip",  group_index = 2 },
  { name = "copilot",  group_index = 3 },
  { name = "buffer",   group_index = 4, keyword_length = 3 },
  { name = "path",     group_index = 5 },
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
    sources = cmp.config.sources(sources),
    formatting = formatting_style,
    completion = {
      completeopt = "menu,menuone",
      keyword_length = 2,
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
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-x>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-o>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    },
  }
  return opts
end
M.config = function(_, opts)
  ---ensure mapping don't exist
  vim.keymap.set({ "i", "s" }, "<A-n>", "<Nop>")
  require("cmp").setup(opts)
end

return M
