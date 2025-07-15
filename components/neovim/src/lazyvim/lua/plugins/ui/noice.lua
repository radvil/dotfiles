return {
  {
    "which-key.nvim",
    optional = true,
    opts = {
      spec = {
        ["<leader>l"] = { name = "logger/noice" },
      },
    },
  },

  {
    "folke/noice.nvim",
    keys = function()
      return {
        {
          "<c-d>",
          function()
            if not require("noice.lsp").scroll(4) then
              return "<c-d>"
            end
          end,
          expr = true,
          desc = "Noice » Scroll forward",
          mode = { "i", "n", "s" },
        },
        {
          "<c-u>",
          function()
            if not require("noice.lsp").scroll(-4) then
              return "<c-u>"
            end
          end,
          expr = true,
          desc = "Noice » Scroll backward",
          mode = { "i", "n", "s" },
        },
        {
          "<S-Enter>",
          function()
            require("noice").redirect(vim.fn.getcmdline())
          end,
          mode = "c",
          desc = "Noice » Redirect cmdline",
        },
        {
          "<leader>ll",
          function()
            require("noice").cmd("last")
          end,
          desc = "Logger » Noice last message",
        },
        {
          "<leader>lh",
          function()
            require("noice").cmd("history")
          end,
          desc = "Logger » Noice message history",
        },
        {
          "<leader>la",
          function()
            require("noice").cmd("all")
          end,
          desc = "Logger » All noice messages",
        },
        {
          "<leader>ld",
          function()
            require("noice").cmd("dismiss")
          end,
          desc = "Logger » Dismiss noice messages",
        },
      }
    end,

    ---@type NoiceConfig
    opts = {
      presets = {
        inc_rename = true,
        bottom_search = true,
        lsp_doc_border = true,
      },
      messages = {
        enabled = true,
        view = "mini",
        view_error = "mini",
        view_warn = "notify",
      },
      lsp = {
        progress = { enabled = false },
        ---message shown by lsp servers
        message = { enabled = true, view = "mini" },
        hover = { enabled = true, silent = true },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
            throttle = 50,
          },
        },
      },
      views = {
        ---display cmdline and popup menu together
        cmdline_popup = {
          relative = "editor",
          position = { col = "50%", row = 5 },
          size = { width = 60, height = "auto" },
          border = { style = "rounded", padding = { 0, 1 } },
        },
        popupmenu = {
          relative = "editor",
          size = { width = 60, height = 9 },
          position = { col = "50%", row = 10 },
          border = { style = "rounded", padding = { 0, 1 } },
        },
      },
      routes = {
        { view = "notify", filter = { event = "msg_showmode" } },
      },
    },
  },

  config = function(_, opts)
    opts = vim.tbl_deep_extend("force", opts or {}) or {}
    if opts and not vim.g.neo_transparent then
      local win_opts = { winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder" }
      local border_opts = { style = "none", padding = { 1, 2 } }
      opts.views.popupmenu.border = border_opts
      opts.views.cmdline_popup.border = border_opts
      opts.views.popupmenu.win_options = win_opts
      opts.views.cmdline_popup.win_options = win_opts
      opts.presets.lsp_doc_border = { views = { hover = { border = border_opts } } }
    end
    require("noice").setup(opts)
  end,
}
