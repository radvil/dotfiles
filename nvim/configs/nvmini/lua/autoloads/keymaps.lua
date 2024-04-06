---@param scope 'session' | 'window'
local tmux_run = function(scope)
  scope = scope or "window"
  vim.ui.input({
    prompt = string.format("Run in a new tmux %s: ", scope),
    completion = "file_in_path", -- :h command-completion
    default = "",
  }, function(value)
    if not value then
      Lonard.warn("Canceled", {
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
vim.api.nvim_create_user_command("Cmds", function() tmux_run("session") end, { desc = "run command inside new tmux [s]ession" })
vim.api.nvim_create_user_command("Cmdw", function() tmux_run("window") end, { desc = "run command inside new tmux [w]indow" })
Lonard.map("n", "<leader>tS", function() tmux_run("session") end, { desc = "run command in new tmux [s]ession" })
Lonard.map("n", "<leader>tW", function() tmux_run("window") end, { desc = "run command in new tmux [w]indow" })
-- stylua: ignore end

-- experimental keymap
Lonard.map({ "n", "x", "v" }, "s", "<nop>", { remap = true, desc = "[reset]" })
Lonard.map({ "n", "i", "x", "v", "s", "o", "c" }, "<a-q>", "<esc>", { desc = "[esc]" })
Lonard.map({ "n", "i", "s", "o" }, "<a-space>", "<esc>", { desc = "[esc] with space" })
Lonard.map({ "i", "n" }, "<c-s>", "<cmd>write<cr>", { desc = "save changes" })
Lonard.map("n", "ZZ", ":conf qa<cr>", { desc = "+confirm quit all" })
Lonard.map("n", "Zt", ":tabclose<cr>", { desc = "quit [t]ab" })
Lonard.map("n", "Zb", ":bdelete<cr>", { desc = "quit [b]uffer" })
Lonard.map("n", "ZB", ":BAD<cr>", { desc = "quit [B]uffers" })
Lonard.map("n", "Zw", "<c-w>c", { desc = "quit [w]indow" })
Lonard.map("n", "Zf", ":fclose<cr>", { desc = "quit [f]loating window" })

if not vim.g.neovide then
  Lonard.map("n", "<leader>fz", function()
    vim.cmd([[call system('zmux')]])
  end, { desc = "[z]mux" })
end

-- toggle autocomplete
Lonard.map("n", "<leader>uC", function()
  local next = not vim.g.neo_autocomplete
  vim.g.neo_autocomplete = next
  vim.cmd.Lazy("load nvim-cmp")
  if next then
    Lonard.info("Code completion set to auto", { title = "Code completion" })
  else
    Lonard.warn("Code completion set to manual", { title = "Code completion" })
  end
end, { desc = "toggle » code completion trigger" })

-- rightclick
-- Lonard.map("n", "<RightMouse>", "<cmd>:popup mousemenu<cr>")

-- toggle transparency
Lonard.map("n", "<leader>uT", function()
  if vim.g.neovide then
    if vim.g.neovide_transparency < 1 then
      vim.g.neovide_transparency = 1
    else
      vim.g.neovide_transparency = 0.96
    end
  else
    Lonard.try(function()
      local colors_name = vim.g.colors_name
      for key, value in pairs({
        tokyonight = "tokyonight",
        monokai = "monokai-pro",
        catppuccin = "catppuccin",
      }) do
        if string.match(colors_name, key) then
          vim.g.neo_transparent = not vim.g.neo_transparent
          vim.cmd.Lazy("reload " .. value .. " noice.nvim" .. " telescope.nvim")
          vim.schedule(function()
            vim.cmd.colorscheme(colors_name)
          end)
          break
        end
      end
    end)
  end
end, { desc = "toggle » transparent background" })

if Lonard.lazy_has("mini.map") then
  for _, key in ipairs({ "n", "N", "*", "#" }) do
    Lonard.map("n", key, key .. "<Cmd>lua require('mini.map').refresh({}, {lines = false, scrollbar = false})<CR>")
  end
end
