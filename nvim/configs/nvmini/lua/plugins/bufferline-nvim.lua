local Kmap = function(lhs, cmd, desc)
  cmd = string.format("<cmd>BufferLine%s<cr>", cmd)
  desc = string.format("tabline » %s", desc)
  return { lhs, cmd, desc = desc }
end

return {
  "akinsho/bufferline.nvim",
  optional = true,
  -- replace all mappings (using tab keymaps instead of buffers)
  keys = function()
    return {
      Kmap("<a-b>", "Pick", "pick & enter"),
      Kmap("<a-q>", "PickClose", "pick & close"),
      Kmap("<leader>bx", "PickClose", "pick & close"),
      Kmap("<a-[>", "CyclePrev", "switch prev"),
      Kmap("<a-]>", "CycleNext", "switch next"),
      Kmap("<a-1>", "GoToBuffer 1", "switch 1st"),
      Kmap("<a-2>", "GoToBuffer 2", "switch 2nd"),
      Kmap("<a-3>", "GoToBuffer 3", "switch 3rd"),
      Kmap("<a-4>", "GoToBuffer 4", "switch 4th"),
      Kmap("<a-5>", "GoToBuffer 5", "switch 5th"),
      Kmap("<leader>bB", "CloseLeft", "close left"),
      Kmap("<leader>bW", "CloseRight", "close right"),
      Kmap("<leader>bC", "CloseOthers", "close others"),
    }
  end,
  opts = function(_, opts)
    local Hl = require("highlights.bufferline-nvim")
    local Has = require("neoverse.utils").lazy_has
    if type(opts.options == "table") then
      opts.options.always_show_bufferline = false
      opts.options.mode = "tabs"
      opts.options.sort_by = "tabs"
      opts.options.move_wraps_at_ends = false
      opts.options.show_tab_indicators = false
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
