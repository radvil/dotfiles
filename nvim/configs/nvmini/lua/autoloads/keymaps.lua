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
-- stylua: ignore start

Utils.map("i", "<c-s>", "<cmd>write<cr>", { desc = "save changes" })
Utils.map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "manual entry" })
Utils.map("n", "<c-w>", "<cmd>tabclose<cr>", { desc = "close tab" })

if not vim.g.neovide then
  Utils.map("n", "<leader>fz", function() vim.cmd([[call system('zmux')]]) end, { desc = "zmux" })
end
-- stylua: ignore end

-- toggle transparency
Utils.map("n", "<leader>uT", function()
  Utils.try(function()
    local colors_name = vim.g.colors_name
    for key, value in pairs({
      tokyonight = "tokyonight.nvim",
      monokai = "monokai-pro.nvim",
      catppuccin = "catppuccin",
    }) do
      if string.match(colors_name, key) then
        vim.g.neo_transparent = not vim.g.neo_transparent
        vim.cmd.Lazy("reload " .. value .. " noice.nvim")
        vim.schedule(function()
          vim.cmd.colorscheme(colors_name)
        end)
        break
      end
    end
  end)
end, { desc = "toggle » transparent background" })