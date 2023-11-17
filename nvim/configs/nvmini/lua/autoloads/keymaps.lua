local Utils = require("neoverse.utils")

Utils.map("i", "<c-s>", "<cmd>write<cr>", { desc = "save changes" })
Utils.map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "manual entry" })
Utils.map("n", "<c-w>", "<cmd>tabclose<cr>", { desc = "close tab" })

if not vim.g.neovide then
  Utils.map("n", "<leader>fz", function()
    vim.cmd([[call system('zmux')]])
  end, { desc = "zmux" })
end

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
