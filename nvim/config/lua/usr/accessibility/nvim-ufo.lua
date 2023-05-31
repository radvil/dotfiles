---@type LazySpec
local M = {}
M[1] = "kevinhwang91/nvim-ufo"
M.enabled = true
M.dependencies = { "kevinhwang91/promise-async", "neovim/nvim-lspconfig" }
local ftMap = {
  git = "",
  -- typescript = { "lsp", "indent" },
  typescript = { "treesitter", "indent" },
  typescriptreact = { "lsp", "indent" },
  html = { "treesitter", "indent" },
  python = "indent",
  scss = "indent",
  vim = "indent",
}
M.config = function()
  ---@param bufnr number
  ---@return Promise
  local function fallbackSelector(bufnr)
    local function handleFallbackException(err, providerName)
      if type(err) == 'string' and err:match('UfoFallbackException') then
        return require('ufo').getFolds(bufnr, providerName)
      else
        return require('promise').reject(err)
      end
    end
    return require('ufo').getFolds(bufnr, 'lsp'):catch(function(err)
      return handleFallbackException(err, 'treesitter')
    end):catch(function(err)
      return handleFallbackException(err, 'indent')
    end)
  end

  require("ufo").setup({
    ---@diagnostic disable-next-line: unused-local
    provider_selector = function(bufnr, filetype, buftype)
      return ftMap[filetype] or fallbackSelector
    end
  })

  vim.keymap.set("n", "zO", function()
    require("ufo").openAllFolds()
  end, { desc = "Fold » Open All" })

  vim.keymap.set("n", "zC", function()
    require("ufo").closeAllFolds()
  end, { desc = "Fold » Close All" })
end
return M
