local function fallbackFoldHandler(_)
  local res = {}
  table.insert(res, { startLine = 1, endLine = 3 })
  table.insert(res, { startLine = 5, endLine = 10 })
  return res
end

local get_providers = function(_, filetype)
  return ({
        git = fallbackFoldHandler,
        typescript = { "lsp", "indent" },
        typescriptreact = { "lsp", "indent" },
        html = { "treesitter", "indent" },
        python = "indent",
        scss = "indent",
        vim = "indent",
      })[filetype] or { "treesitter", "indent" }
end

local function register_keymaps()
  vim.keymap.set("n", "zR", function()
    require("ufo").openAllFolds()
  end, { desc = "[Fold] Open all" })
  vim.keymap.set("n", "zM", function()
    require("ufo").closeAllFolds()
  end, { desc = "[Fold] Close all" })
  -- local winid = require("ufo").peekFoldedLinesUnderCursor()
  -- if winid then
  --   local bufnr = vim.api.nvim_win_get_buf(winid)
  --   local keys = { "a", "i", "o", "A", "I", "O", "gd", "gr" }
  --   for _, k in ipairs(keys) do
  --     vim.keymap.set("n", k, "<CR>" .. k, { noremap = false, buffer = bufnr })
  --   end
  -- end
end

---@type LazySpec
local M = {}
M[1] = "kevinhwang91/nvim-ufo"
M.dependencies = { "kevinhwang91/promise-async", "neovim/nvim-lspconfig" }
M.config = function()
  require("ufo").setup({ provider_selector = get_providers })
  register_keymaps()
end
return M
