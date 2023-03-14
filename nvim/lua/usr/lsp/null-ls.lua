--- @desc: languages linter and formatter
--- @type LazySpec
local M = {}

M[1] = "jose-elias-alvarez/null-ls.nvim"

M.event = "BufReadPre"

M.dependencies = {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    local defaults = {
      "markdownlint",
      "shellcheck",
      "prettierd",
      "eslint_d",
      "stylua",
      "shfmt",
    }
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, defaults)
    end
  end,
}

---@param files table
local with_root_files = function(files)
  return function(utils)
    return utils.root_has_file(files)
  end
end

M.opts = function()
  local nls = require("null-ls")
  return {
    sources = {
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.eslint_d.with({
        condition = with_root_files({
          ".eslint.json",
          ".eslintrc",
          ".eslintjs",
        }),
      }),

      nls.builtins.formatting.shfmt,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.formatting.prettierd,
      nls.builtins.formatting.stylua.with({
        condition = with_root_files({
          "stylua.toml",
          "luarc.json",
          ".stylua.toml",
          ".luarc",
        }),
      }),
    },
  }
end

return M
