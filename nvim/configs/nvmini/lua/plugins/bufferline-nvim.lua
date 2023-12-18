return {
  "akinsho/bufferline.nvim",
  optional = true,
  opts = function(_, opts)
    local Hl = require("highlights.bufferline-nvim")
    local Has = require("neoverse.utils").lazy_has
    if type(opts.options == "table") then
      table.insert(opts.options.offsets, {
        filetype = "neo-tree",
        highlight = "BufferLineFill",
        text_align = "left",
        separator = true,
        text = function()
          return "󱉭 " .. vim.fn.getcwd():gsub(os.getenv("HOME"), "~")
        end,
      })
    end
    if Has("catppuccin") and string.match(vim.g.colors_name, "catppuccin") then
      opts.highlights = Hl.catppuccin()
    elseif Has("tokyonight.nvim") and string.match(vim.g.colors_name, "tokyonight") then
      opts.highlights = Hl.tokyonight()
    end
  end,
}
