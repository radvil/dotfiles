local M = {}

M[1] = "L3MON4D3/LuaSnip"

M.event = "InsertEnter"

-- M.dependencies = {
--   "rafamadriz/friendly-snippets",
-- }

M.config = function()
  local vscode_loader = require("luasnip.loaders.from_vscode")
  ---@desc load global snippets if has general pattern like	from friendly-snippets
  vscode_loader.lazy_load()
  ---@desc load custom snippets
  vscode_loader.lazy_load({
    paths = {
      rvim.path.config .. "/assets/snippets/all/",
      rvim.path.config .. "/assets/snippets/angular/",
    },
  })
end

M.keys = {
  -- {
  --   "<Tab>",
  --   function()
  --     return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
  --   end,
  --   silent = true,
  --   expr = true,
  --   mode = "i",
  -- },
  {
    "<Tab>",
    function()
      require("luasnip").jump(1)
    end,
    mode = "s",
  },
  {
    "<S-Tab>",
    function()
      require("luasnip").jump(-1)
    end,
    mode = { "i", "s" },
  },
}

M.opts = {
  delete_check_events = "TextChanged",
  history = true,
}

return M
