---@desc noicer UI
---@type LazySpec
local M = {}
M[1] = "folke/noice.nvim"
M.enabled = false
M.event = "VeryLazy"
M.dependencies = {
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  "stevearc/dressing.nvim",
}
M.opts = {
  presets = {
    long_message_to_split = false,
    ---@desc position the cmdline and popupmenu together
    command_palette = true,
    bottom_search = false,
    lsp_doc_border = true,
  },
  health = { checker = true },
  smart_move = {
    ---@desc noice tries to move out of the way of existing floating windows.
    enabled = true,
    ---@desc add any filetypes here, that shouldn't trigger smart move.
    excluded_filetypes = {
      "cmp_menu",
      "cmp_docs",
      "notify",
    },
  },
  views = {
    split = {
      ---@desc enter window on triggered
      enter = true,
    },
  },
  lsp = {
    progress = {
      enabled = false,
      -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
      -- See the section on formatting for more details on how to customize.
      format = "lsp_progress",
      format_done = "lsp_progress_done",
      throttle = 1000 / 30, -- frequency to update lsp progress message
      view = "mini",
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    {
      opts = { skip = true },
      filter = {
        event = "msg_show",
        find = "written",
      },
    },
    ---@desc always route any messages with more than 20 lines to the split view
    {
      view = "split",
      filter = {
        event = "msg_show",
        min_height = 20,
      },
    },
  },
}
if rvim.theme.colorscheme == "catppuccin" then
  ---@desc override default cmdline popup view
  M.opts.views.cmdline_popup = {
    border = {
      padding = { 0, 1 },
    },
    win_options = {
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    },
  }
end
return M
