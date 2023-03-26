local M = {}

M[1] = "nvim-neo-tree/neo-tree.nvim"

M.branch = "v2.x"

M.dependencies = {
  "nvim-tree/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
}

M.keys = {
  {
    "<Leader>e",
    "<Cmd>Neotree left<Cr>",
    desc = "[Tree] Open left",
  },
}

if not rvim.file_explorer.enabled then
  table.insert(M.keys, {
    "<Leader><Space>",
    "<CMD>Neotree float<CR>",
    desc = "[Tree] Open float",
  })
end

M.opts = {
  enable_git_status = true,
  enable_diagnostics = true,
  close_if_last_window = true,
  popup_border_style = "rounded",
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      padding = 2,
      indent_size = 3,
      indent_marker = "│",
      with_markers = true,
      with_expanders = true,
      expander_expanded = "",
      expander_collapsed = "",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      highlight = "NeoTreeFileIcon",
      folder_closed = "",
      folder_empty = "ﰊ",
      folder_open = "",
      default = "*",
    },
    modified = {
      highlight = "NeoTreeModified",
      symbol = "[+]",
    },
    name = {
      highlight = "NeoTreeFileName",
      use_git_status_colors = true,
      trailing_slash = false,
    },
    git_status = {
      symbols = {
        added = "",
        modified = " 💋",
        deleted = " ✖",
        renamed = " ",
        untracked = " ",
        ignored = " ",
        unstaged = " ",
        staged = " ",
        conflict = " ",
      },
    },
  },
  window = {
    width = 40,
    position = "left",
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      -- reset defaults
      -- do not set to nil, instead set it to and empty string
      ["z"] = "",

      ["<Cr>"] = "open",
      ["w"] = "open",
      ["<2-LeftMouse>"] = "open",
      ["sv"] = "open_vsplit",
      ["sh"] = "open_split",
      ["t"] = "open_tabnew",
      ["C"] = "close_node",
      ["zC"] = "close_all_nodes",
      ["zO"] = "expand_all_nodes",

      ["a"] = "add",
      ["d"] = "delete",
      ["r"] = "rename",
      ["c"] = "copy",
      ["m"] = "move",

      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",

      ["<"] = "prev_source",
      [">"] = "next_source",
      ["?"] = "show_help",
      ["P"] = { "toggle_preview", config = { use_float = true } },
      ["<Esc>"] = "revert_preview",
      ["H"] = "toggle_hidden",
      ["[g"] = "prev_git_modified",
      ["]g"] = "next_git_modified",

      ["<Bs>"] = "navigate_up",
      ["."] = "set_root",
      ["q"] = "close_window",
      ["<A-Space>"] = "close_window",
      ["R"] = "refresh",

      ["/"] = "fuzzy_finder",
      ["<C-/>"] = "fuzzy_finder_directory",
      ["<C-f>"] = "filter_on_submit",
      ["<C-x>"] = "clear_filter",
      ["A"] = false,
      ["f"] = false,
      ["l"] = false,
      ["Space"] = false,
    },
  },
  filesystem = {
    follow_current_file = true,
    use_libuv_file_watcher = true,
    hijack_netrw_behavior = "open_default",
    group_empty_dirs = false,
    filtered_items = {
      visible = false,
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_hidden = true,
      hide_by_name = {
        "node_modules",
      },
      hide_by_pattern = {
        "*.angular",
      },
      always_show = {
        ".gitignored",
      },
      never_show = {
        ".DS_Store",
        "thumbs.db",
      },
      never_show_by_pattern = {
        --".null-ls_*",
      },
    },
  },
  buffers = {
    follow_current_file = true,
    group_empty_dirs = true,
    show_unloaded = true,
  },
}

M.init = function()
  vim.cmd([[let g:neo_tree_remove_legacy_commands = 1]])
  vim.cmd([[nnoremap \ :Neotree reveal<cr>]])

  vim.fn.sign_define("DiagnosticSignError", {
    texthl = "DiagnosticSignError",
    text = " ",
  })

  vim.fn.sign_define("DiagnosticSignWarn", {
    texthl = "DiagnosticSignWarn",
    text = " ",
  })

  vim.fn.sign_define("DiagnosticSignInfo", {
    texthl = "DiagnosticSignInfo",
    text = " ",
  })

  vim.fn.sign_define("DiagnosticSignHint", {
    texthl = "DiagnosticSignHint",
    text = "",
  })
end

return M
