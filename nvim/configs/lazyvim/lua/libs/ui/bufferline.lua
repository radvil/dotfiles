return {
  "akinsho/bufferline.nvim",

  config = function(_, opts)
    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      show_close_icon = false,
      show_tab_indicators = true,
      always_show_bufferline = false,
      indicator = { style = "icon" },
      diagnostics = "nvim_lsp",
      separator_style = "thin",
      hover = {
        enabled = true,
        reveal = { "close" },
        delay = 200,
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = " ~ TREE VIEW",
          highlight = "BufferLineBackground",
          text_align = "left",
          separator = false,
        },
      },
    })

    require("bufferline").setup(opts)
  end,

  opts = function(_, opts)
    if vim.cmd.colorscheme == "catppuccin" then
      opts.options.highlights = require("catppuccin.groups.integrations.bufferline").get()
    end
    return opts
  end,

  keys = function()
    return {
      {
        "<Leader>bS",
        ":BufferLineSortByTabs<cr>",
        desc = "Buffer » Sort by directory",
      },
      {
        "<Leader>bs",
        ":BufferLineSortByDirectory<cr>",
        desc = "Buffer » Sort by relative directory",
      },
      {
        "<Leader>bp",
        "<Cmd>BufferLineTogglePin<CR>",
        desc = "Buffer » Toggle pin",
      },
      {
        "<a-b>",
        "<Cmd>BufferLinePick<CR>",
        desc = "Buffer » Pick",
      },
      {
        "<A-.>",
        "<Cmd>BufferLineMoveNext<CR>",
        desc = "buffer » shift right",
      },
      {
        "<A-[>",
        "<Cmd>BufferLineCyclePrev<CR>",
        desc = "buffer » switch prev",
      },
      {
        "<a-[>",
        "<Cmd>BufferLineCyclePrev<CR>",
        desc = "Buffer » Switch prev",
      },
      {
        "<a-]>",
        "<Cmd>BufferLineCycleNext<CR>",
        desc = "Buffer » Switch next",
      },
      {
        "<a-1>",
        "<Cmd>BufferLineGoToBuffer 1<CR>",
        desc = "Buffer » Switch 1st",
      },
      {
        "<a-2>",
        "<Cmd>BufferLineGoToBuffer 2<CR>",
        desc = "Buffer » Switch 2nd",
      },
      {
        "<a-3>",
        "<Cmd>BufferLineGoToBuffer 3<CR>",
        desc = "Buffer » Switch 3rd",
      },
      {
        "<a-4>",
        "<Cmd>BufferLineGoToBuffer 4<CR>",
        desc = "Buffer » Switch 4th",
      },
      {
        "<a-5>",
        "<Cmd>BufferLineGoToBuffer 5<CR>",
        desc = "Buffer » Switch 5th",
      },
      {
        "<leader>bB",
        ":BufferLineCloseLeft<cr>",
        desc = "Buffer » Close left",
      },
      {
        "<leader>bW",
        ":BufferLineCloseRight<cr>",
        desc = "Buffer » Close right",
      },
      {
        "<leader>bC",
        ":BufferLineCloseOthers<cr>",
        desc = "Buffer » Close others",
      },
    }
  end,
}
