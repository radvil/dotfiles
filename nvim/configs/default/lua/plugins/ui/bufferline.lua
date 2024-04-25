---@diagnostic disable: param-type-mismatch
local blacklist = {
  -- popups
  "TelescopeResults",
  "TelescopePrompt",
  "neo-tree-popup",
  "DressingInput",
  "flash_prompt",
  "cmp_menu",
  "WhichKey",
  "incline",
  "notify",
  "prompt",
  "notify",
  "noice",
  "lazy",

  -- windows
  "DiffviewFiles",
  "checkhealth",
  "dashboard",
  "NvimTree",
  "neo-tree",
  "Outline",
  "prompt",
  "oil",
  "qf",
}

local Kmap = function(lhs, cmd, desc)
  cmd = string.format("<cmd>BufferLine%s<cr>", cmd)
  desc = string.format("bufferline » %s", desc)
  return { lhs, cmd, desc = desc }
end

return {
  "akinsho/bufferline.nvim",
  dependencies = { "mini.bufremove" },
  commit = "64e2c5def50dfd6b6f14d96a45fa3d815a4a1eef",
  event = "LazyFile",
  keys = function()
    return {
      Kmap("<a-q>", "PickClose", "pick & close"),
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
    local defaults = {
      options = {
        mode = "tabs",
        sort_by = "tabs",
        buffer_close_icon = "",
        diagnostics = false,
        move_wraps_at_ends = false,
        show_tab_indicators = false,
        always_show_bufferline = false,
        close_command = "tabclose! %d",
        right_mouse_command = false,
        show_close_icon = false,
        show_buffer_icons = true,
        separator_style = "thin",
        indicator = {
          ---@type "icon" | "underline" | "none"
          style = "icon",
        },
        hover = {
          enabled = true,
          reveal = { "close" },
          delay = 100,
        },
        custom_filter = function(bufnr)
          return not vim.tbl_contains(blacklist, vim.bo[bufnr].filetype)
        end,
        offsets = { },
      },
    }

    local match = function(name)
      return LazyVim.has(name) and string.match(vim.g.colors_name, name)
    end

    if match("catppuccin") then
      opts.highlights = require("hi.bufferline").catppuccin()
    elseif match("tokyonight") then
      opts.highlights = require("hi.bufferline").tokyonight()
    end

    opts = vim.tbl_deep_extend("force", defaults, opts or {})

    return opts
  end,
}
