local Kmap = function(lhs, cmd, desc)
  cmd = string.format("<cmd>BufferLine%s<cr>", cmd)
  return { lhs, cmd, desc = desc }
end

return {
  "akinsho/bufferline.nvim",
  optional = true,
  -- replace all mappings (using tab keymaps instead of buffers)
  keys = function()
    return {
      Kmap("<a-b>", "Pick", "pick & enter tab"),
      Kmap("<leader>bc", "PickClose", "pick & close tab"),
      Kmap("<a-[>", "CyclePrev", "switch prev tab"),
      Kmap("<a-]>", "CycleNext", "switch next tab"),
      Kmap("<a-1>", "GoToBuffer 1", "switch to tab #1"),
      Kmap("<a-2>", "GoToBuffer 2", "switch to tab #2"),
      Kmap("<a-3>", "GoToBuffer 3", "switch to tab #3"),
      Kmap("<a-4>", "GoToBuffer 4", "switch to tab #4"),
      Kmap("<a-5>", "GoToBuffer 5", "switch to tab #5"),
      Kmap("<leader>bB", "CloseLeft", "close left tabs"),
      Kmap("<leader>bW", "CloseRight", "close right tabs"),
      Kmap("<leader>bC", "CloseOthers", "close other tabs"),
    }
  end,
  opts = function(_, opts)
    if type(opts.options == "table") then
      opts.options.mode = "tabs"
      opts.options.sort_by = "tabs"
      opts.options.buffer_close_icon = ""
      opts.options.diagnostics = false
      opts.options.move_wraps_at_ends = false
      opts.options.show_tab_indicators = false
      opts.options.always_show_bufferline = false
      opts.options.close_command = "tabclose! %d"
      opts.options.right_mouse_command = false
      opts.options.close_command = nil
      table.insert(opts.options.offsets, {
        filetype = "neo-tree",
        highlight = "BufferLineFill",
        text_align = "left",
        separator = true,
        text = function()
          local path = vim.fn.getcwd():gsub(os.getenv("HOME"), "~") --[[@as string]]
          local sep = package.config:sub(1, 1)
          local parts = vim.split(path, "[\\/]")
          if #parts > 4 then
            parts = { parts[1], " … ", parts[#parts - 1], parts[#parts] }
            return "󱉭 " .. table.concat(parts, sep)
          else
            return "󱉭 " .. path
          end
        end,
      })
    end
    local Hl = require("highlights.bufferline-nvim")
    local Match = function(name)
      return Lonard.lazy_has(name) and string.match(vim.g.colors_name, name)
    end
    if Match("catppuccin") then
      opts.highlights = Hl.catppuccin()
    elseif Match("tokyonight") then
      opts.highlights = Hl.tokyonight()
    end
  end,
}
