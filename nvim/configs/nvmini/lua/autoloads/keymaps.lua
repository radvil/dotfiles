local Utils = require("neoverse.utils")

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
        vim.opt.cursorline = not vim.opt.cursorline:get()
        vim.cmd.Lazy("reload " .. value .. " noice.nvim")
        vim.cmd.colorscheme(colors_name)
        break
      end
    end
  end)
end, { desc = "Toggle » Transparent Background" })
