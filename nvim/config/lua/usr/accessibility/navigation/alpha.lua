---@desc dashboard
---@LazySpec
local M = {}
M[1] = "goolord/alpha-nvim"
M.event = "VimEnter"
M.opts = function()
  local A = require("alpha.themes.dashboard")
  A.section.header.val = require("media.ascii-arts").Default
  A.section.buttons.val = {
    A.button("p", " " .. " Plugins", ":Lazy<CR>"),
    A.button("o", "📁" .. " Recent files", ":Telescope oldfiles<CR>"),
    A.button("f", "🔭" .. " Find file", ":Telescope find_files<CR>"),
    A.button("w", "🔎" .. " Search text", ":Telescope live_grep<CR>"),
    A.button("t", "📌" .. " Find tasks", ":TodoTelescope<CR>"),
    A.button(".", "🔧" .. " Configuration", ":e $MYVIMRC<CR>"),
    A.button("s", "🕗" .. " Restore session", "<Cmd>lua require('persistence').load()<Cr>"),
  }
  for _, button in ipairs(A.section.buttons.val) do
    button.opts.hl = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaShortcut"
  end
  A.section.footer.opts.hl = "Type"
  A.section.header.opts.hl = "AlphaHeader"
  A.section.buttons.opts.hl = "AlphaButtons"
  A.opts.layout[1].val = 8
  return A
end
M.config = function(_, A)
  -- close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end
  require("alpha").setup(A.opts)
  vim.api.nvim_create_autocmd("User", {
    pattern = "RvimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      A.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end
return M
