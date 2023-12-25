return {
  "willothy/nvim-cokeline",
  lazy = false,
  keys = function()
    local Kmap = function(lhs, cmd, desc)
      cmd = string.format("<Plug>(cokeline-%s)", cmd)
      desc = string.format("cokeline » %s", desc)
      return { lhs, cmd, desc = desc }
    end
    local keys = {
      Kmap("<a-b>", "pick-focus", "pick to focus"),
      Kmap("<a-q>", "pick-close", "pick to close"),
      Kmap("<leader>bx", "pick-close", "pick to close"),
      Kmap("<a-[>", "focus-prev", "focus prev"),
      Kmap("<a-]>", "focus-next", "focus next"),
      Kmap("<a-.>", "switch-prev", "move to prev"),
      Kmap("<a-,>", "switch-next", "move to next"),
    }
    for i = 1, 5 do
      table.insert(keys, Kmap(("<a-%s>"):format(i), ("focus-%s"):format(i), ("move to buffer number %s"):format(i)))
    end
    return keys
  end,
  opts = function()
    local P = require("neoverse.config").palette
    local hex = require("cokeline.hlgroups").get_hl_attr
    local is_picking_focus = require("cokeline.mappings").is_picking_focus
    local is_picking_close = require("cokeline.mappings").is_picking_close
    local transparent = vim.g.neo_transparent
    local bg = transparent and "NONE" or hex("Normal", "bg")
    local bar = function(buffer)
      return buffer.is_focused and P.dark2 or "#181827"
    end

    local opts = {
      fill_hl = "TabLineFill",
      show_if_buffers_are_at_least = 1,
      sidebar = {
        filetype = { "NvimTree", "neo-tree" },
        components = {
          {
            text = function()
              return "󱉭 " .. vim.fn.getcwd():gsub(os.getenv("HOME"), "~")
            end,
            fg = hex("Comment", "fg"),
          },
        },
      },
      -- rendering = { max_buffer_width = 27 },
      buffers = {
        focus_on_delete = "prev",
        ---@type 'last' | 'next' | 'directory' | 'number' | fun(a: Buffer, b: Buffer):boolean
        new_buffers_position = "next",
      },
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and hex("Normal", "fg") or hex("Comment", "fg")
        end,
        bg = bar,
      },

      components = {
        {
          text = function(buf)
            return buf.index == 1 and "" or " "
          end,
          bg = bg,
        },
        {
          text = "",
          bg = bg,
          fg = bar,
        },
        -- { text = " " },
        -- modified
        {
          text = function(buf)
            return buf.is_modified and "[+]" or ""
          end,
          fg = function()
            return hex("Comment", "fg")
          end,
        },
        -- diagnostics error
        {
          text = function(buf)
            local count = buf.diagnostics.errors
            return count > 0 and ("E" .. count .. " ") or ""
          end,
          fg = function()
            return hex("DiagnosticError", "fg")
          end,
          bold = true,
        },
        -- diagnostics warning
        {
          text = function(buf)
            local count = buf.diagnostics.warnings
            return count > 0 and ("W" .. count .. " ") or ""
          end,
          fg = function()
            return hex("DiagnosticWarn", "fg")
          end,
          bold = true,
        },
        -- filename
        {
          text = function(buffer)
            return buffer.filename
          end,
          fg = function(buffer)
            return buffer.buf_hovered and P.blue or nil
          end,
          bold = false,
        },
        { text = " " },
        -- devicon + close
        {
          delete_buffer_on_left_click = true,
          text = function(buffer)
            if is_picking_focus() or is_picking_close() then
              return buffer.pick_letter .. " "
            elseif buffer.is_hovered then
              return "󰅙 "
            else
              return buffer.devicon.icon
            end
          end,
          fg = function(buffer)
            if is_picking_focus() then
              return hex("DiagnosticError", "fg")
            elseif is_picking_close() or buffer.is_hovered then
              return "#ff0000"
            elseif buffer.buf_hovered then
              return P.blue
            elseif buffer.is_focused then
              return buffer.devicon.color
            else
              return hex("Comment", "fg")
            end
          end,
          italic = function()
            return is_picking_focus() or is_picking_close()
          end,
          bold = function()
            return is_picking_focus() or is_picking_close()
          end,
        },
        {
          text = "",
          fg = bar,
          bg = bg,
        },
      },
    }

    return opts
  end,
}
