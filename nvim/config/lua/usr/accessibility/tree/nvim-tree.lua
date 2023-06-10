local icons = require("media.icons")
---@type LazySpec
local M = {}
M[1] = "nvim-tree/nvim-tree.lua"
M.cmd = "NvimTree"
M.enabled = rnv.opt.tree == "nvim-tree"
M.dependencies = { "nvim-tree/nvim-web-devicons" }
M.keys = {
  {
    "<Leader>e",
    "<Cmd>NvimTreeToggle<Cr>",
    desc = "nvimtree » toggle",
  },
}
M.opts = {
  hijack_unnamed_buffer_when_opening = false,
  auto_reload_on_write = true,
  sync_root_with_cwd = true,
  hijack_cursor = true,
  sort_by = "name",
  hijack_directories = {
    auto_open = false,
    enable = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      warning = icons.Diagnostics.Warn,
      error = icons.Diagnostics.Error,
      hint = icons.Diagnostics.Hint,
      info = icons.Diagnostics.Info,
    },
  },
  update_focused_file = {
    update_cwd = false,
    update_root = false,
    enable = true,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 200,
  },
  filesystem_watchers = {
    enable = true,
  },
  view = {
    relativenumber = false,
    signcolumn = "yes",
    number = false,
    side = "left",
    width = 46,
  },
  renderer = {
    highlight_opened_files = "name",
    root_folder_modifier = ":t",
    root_folder_label = false,
    indent_markers = {
      enable = true,
      icons = {
        corner = "└",
        edge = "│",
        -- edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      symlink_arrow = " " .. icons.Common.SymlinkArrow .. " ",
      padding = " ",
      show = {
        folder_arrow = true,
        folder = true,
        file = true,
        git = false,
      },
      glyphs = {
        symlink = icons.Common.Symlink,
        default = icons.Common.File,
        folder = {
          default = icons.Folder.Default,
          empty = icons.Folder.Empty,
          empty_open = icons.Folder.EmptyOpened,
          open = icons.Folder.Opened,
          symlink = icons.Folder.Symlink,
          symlink_open = icons.Folder.SymlinkOpened,
          arrow_open = icons.Folder.ArrowOpened,
          arrow_closed = icons.Folder.ArrowClosed,
        },
        git = {
          untracked = icons.Git.Untracked,
          unstaged = icons.Git.Unstaged,
          unmerged = icons.Git.Unmerged,
          renamed = icons.Git.Renamed,
          deleted = icons.Git.Deleted,
          ignored = icons.Git.Ignored,
          staged = icons.Git.Staged,
        },
      },
    },
    special_files = {
      "index.ts",
      "Cargo.toml",
      "README.md",
      "readme.md",
      "Makefile",
      "init.lua",
      "angular.json",
    },
  },
  filters = {
    dotfiles = true,
    custom = {
      "node_modules",
      "\\.cache",
      "dist",
    },
  },
  trash = {
    require_confirm = true,
    cmd = "trash",
  },
  live_filter = {
    prefix = "FILTER 🔎",
    always_show_folders = true,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      restrict_above_cwd = false,
      global = false,
      enable = true,
    },
    open_file = {
      quit_on_open = true,
      resize_window = true,
    },
  },
  notify = {
    threshold = vim.log.levels.INFO,
  },
  ui = {
    confirm = {
      remove = true,
      trash = true,
    },
  },
  on_attach = function(buffer)
    local api = require("nvim-tree.api")
    local opts = function(desc)
      return {
        desc = "[Tree] " .. desc,
        buffer = buffer,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end

    -- general
    Map("n", "J", "5j", opts("Jump 5 down"))
    Map("n", "K", "5k", opts("Jump 5 up"))
    Map("n", "R", api.tree.reload, opts("Refresh"))
    Map("n", "H", api.tree.toggle_hidden_filter, opts("Toggle hidden"))
    Map("n", "!", api.node.show_info_popup, opts("Info"))
    Map("n", "?", api.tree.toggle_help, opts("Help"))

    -- tree node
    Map("n", "o", api.node.open.edit, opts("Open"))
    Map("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
    Map("n", "l", api.node.open.no_window_picker, opts("Open: no window picker"))
    Map("n", "<CR>", api.node.open.no_window_picker, opts("Open: no window picker"))
    Map("n", "vs", api.node.open.vertical, opts("Open vertical"))
    Map("n", "sp", api.node.open.horizontal, opts("Open horizontal"))
    Map("n", "w", api.node.open.preview, opts("Open preview"))

    -- tree navigation
    Map("n", "zO", api.tree.expand_all, opts("Expand all"))
    Map("n", "zC", api.tree.collapse_all, opts("Collapse all"))
    Map("n", "<", api.tree.change_root_to_parent, opts("Up"))
    Map("n", ">", api.tree.change_root_to_node, opts("CD"))
    Map("n", "<BS>", api.node.navigate.parent_close, opts("Close directory"))
    Map("n", "h", api.node.navigate.parent_close, opts("Close directory"))
    Map("n", "b", api.node.navigate.parent, opts("Parent directory"))
    Map("n", "]d", api.node.navigate.diagnostics.next, opts("[Diag] next"))
    Map("n", "[d", api.node.navigate.diagnostics.prev, opts("[Diag] prev"))
    Map("n", "]s", api.node.navigate.sibling.next, opts("Next sibling"))
    Map("n", "[s", api.node.navigate.sibling.prev, opts("Previous sibling"))

    -- file system
    Map("n", "a", api.fs.create, opts("Create"))
    Map("n", "x", api.fs.cut, opts("Cut"))
    Map("n", "d", api.fs.trash, opts("Move to trash"))
    Map("n", "D", api.fs.remove, opts("Delete"))
    Map("n", "c", api.fs.copy.node, opts("Copy"))
    Map("n", "y", api.fs.copy.filename, opts("Copy name"))
    Map("n", "Y", api.fs.copy.relative_path, opts("Copy relative path"))
    Map("n", "<C-y>", api.fs.copy.absolute_path, opts("Copy absolute path"))
    Map("n", "p", api.fs.paste, opts("Paste"))
    Map("n", "r", api.fs.rename, opts("Rename"))
  end,
}

return M
