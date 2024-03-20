local Utils = require("neoverse.utils")

---@param scope 'session' | 'window'
local tmux_run = function(scope)
  scope = scope or "window"
  vim.ui.input({
    prompt = string.format("Run in a new tmux %s: ", scope),
    completion = "file_in_path", -- :h command-completion
    default = "",
  }, function(value)
    if not value then
      vim.notify("Canceled", vim.log.levels.WARN, {
        title = "Run Command",
        icon = " ",
      })
    else
      local prefix = scope == "window" and "cmdw" or "cmds"
      local name = prefix .. " " .. value
      vim.cmd(string.format("call system('%s')", name))
    end
  end)
end

-- stylua: ignore start
vim.api.nvim_create_user_command("Cmds", function() tmux_run("session") end, { desc = "Run command inside new tmux session" })
vim.api.nvim_create_user_command("Cmdw", function() tmux_run("window") end, { desc = "Run command inside new tmux window" })
Utils.map("n", "<leader>tS", function() tmux_run("session") end, { desc = "Run command in new tmux session" })
Utils.map("n", "<leader>tW", function() tmux_run("window") end, { desc = "Run command in new tmux window" })
-- stylua: ignore end

-- experimental keymap
Utils.map({ "n", "x", "v" }, "s", "<nop>", { desc = "[reset]" })
Utils.map({ "i", "s", "o" }, "<a-q>", "<esc>", { desc = "[esc]" })
Utils.map({ "i", "s", "o" }, "<a-space>", "<esc>", { desc = "[esc] with space" })

Utils.map({ "i", "n" }, "<c-s>", "<cmd>write<cr>", { desc = "save changes" })
Utils.map("n", "<leader>K", "<cmd>nrm! K<cr>", { desc = "manual entry" })
Utils.map("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "[tab] prev" })
Utils.map("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "[tab] next" })
Utils.map("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "[tab] quit" })

Utils.map("n", "ZZ", ":qa<cr>", { desc = "quit session" })
Utils.map("n", "Zt", ":tabclose<cr>", { desc = "quit [t]ab" })
Utils.map("n", "Zb", ":bdelete<cr>", { desc = "quit [b]uffer" })
Utils.map("n", "ZB", ":BAD<cr>", { desc = "quit [B]uffers" })
Utils.map("n", "Zw", "<c-w>c", { desc = "quit [w]indow" })
Utils.map("n", "Zf", ":fclose<cr>", { desc = "quit [f]loating window" })

if not vim.g.neovide then
  Utils.map("n", "<leader>fz", function()
    vim.cmd([[call system('zmux')]])
  end, { desc = "zmux" })
end

-- toggle autocomplete
Utils.map("n", "<leader>uC", function()
  local next = not vim.g.neo_autocomplete
  vim.g.neo_autocomplete = next
  vim.cmd.Lazy("load nvim-cmp")
  if next then
    Utils.info("Code completion set to auto", { title = "Code completion" })
  else
    Utils.warn("Code completion set to manual", { title = "Code completion" })
  end
end, { desc = "toggle » code completion trigger" })

-- rightclick
-- Utils.map("n", "<RightMouse>", "<cmd>:popup mousemenu<cr>")

-- toggle transparency
Utils.map("n", "<leader>uT", function()
  Utils.try(function()
    local colors_name = vim.g.colors_name
    for key, value in pairs({
      tokyonight = "tokyonight",
      monokai = "monokai-pro.nvim",
      catppuccin = "catppuccin",
    }) do
      if string.match(colors_name, key) then
        vim.g.neo_transparent = not vim.g.neo_transparent
        vim.g.neo_winborder = vim.g.neo_transparent and "single" or "none"
        vim.cmd.Lazy("reload " .. value .. " noice.nvim" .. " telescope.nvim")
        vim.schedule(function()
          vim.cmd.colorscheme(colors_name)
        end)
        break
      end
    end
  end)
end, { desc = "toggle » transparent background" })
