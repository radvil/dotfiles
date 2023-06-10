local icons = require("media.icons")
---@type LazySpec
local M = {}
M[1] = "nvim-neo-tree/neo-tree.nvim"
M.enabled = function()
  return rnv.opt.tree == "neotree"
end
M.dependencies = {
  "nvim-tree/nvim-web-devicons",
  "s1n7ax/nvim-window-picker",
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
}

M.keys = {
  {
    "<Leader>e",
    function()
      require("neo-tree.command").execute({
        dir = require("utils").get_root(),
        toggle = true,
      })
    end,
    desc = "neotree » toggle (root)",
  },
  {
    "<Leader>E",
    function()
      require("neo-tree.command").execute({
        dir = vim.loop.cwd(),
        toggle = true,
      })
    end,
    desc = "neotree » toggle",
  },
}

M.deactivate = function()
  vim.cmd([[Neotree close]])
end

M.init = function()
  vim.g.neo_tree_remove_legacy_commands = 1
  if vim.fn.argc() == 1 then
    ---@diagnostic disable-next-line: param-type-mismatch
    local stat = vim.loop.fs_stat(vim.fn.argv(0))
    if stat and stat.type == "directory" then
      require("neo-tree")
    end
  end
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
local i = function(icon)
  return string.format("%s ", icon)
end
M.opts = {
  close_if_last_window = true,
  popup_border_style = "rounded",
  use_default_mappings = false,
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = true,
    use_libuv_file_watcher = true,
  },
  default_component_configs = {
    indent = {
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    git_status = {
      symbols = {
        -- Change type
        added = i(icons.Git.AddedFilled),
        deleted = i(icons.Git.DeletedFilled),
        modified = i(icons.Git.Modified),
        renamed = i(icons.Git.Renamed),
        -- Status type
        staged = i(icons.Git.StagedFilled),
        unstaged = i(icons.Git.UnstagedFilled),
        untracked = i(icons.Git.Untracked),
        conflict = i(icons.Git.Conflict),
        ignored = i(icons.Git.Ignored),
      },
    },
  },
  buffers = {
    follow_current_file = true,
    group_empty_dirs = true,
    show_unloaded = true,
  },
  window = {
    width = 46,
    position = "left",
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["l"] = "open",
      ["o"] = "open_with_window_picker",
      ["<cr>"] = "open",
      ["<2-LeftMouse>"] = "open",
      ["gy"] = "open_vsplit",
      ["gx"] = "open_split",

      ["t"] = "open_tabnew",
      ["h"] = "close_node",
      ["za"] = "toggle_node",
      ["zc"] = "close_node",
      ["zC"] = "close_all_nodes",
      ["zO"] = "expand_all_nodes",

      ["a"] = "add",
      ["d"] = "delete",
      ["r"] = "rename",
      ["<F2>"] = "rename",
      ["c"] = "copy",
      ["m"] = "move",

      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",

      ["<bs>"] = "navigate_up",
      ["?"] = "show_help",
      ["w"] = "toggle_preview",
      ["W"] = { "toggle_preview", config = { use_float = true } },
      ["<esc>"] = "revert_preview",
      ["H"] = "toggle_hidden",
      ["[g"] = "prev_git_modified",
      ["]g"] = "next_git_modified",

      ["."] = "set_root",
      ["R"] = "refresh",
      ["q"] = "close_window",

      ["/f"] = "fuzzy_finder",
      ["/d"] = "fuzzy_finder_directory",
      ["//"] = "filter_on_submit",
    },
  },
}

M.config = function(_, opts)
  require("neo-tree").setup(opts)
  vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*lazygit",
    callback = function()
      if package.loaded["neo-tree.sources.git_status"] then
        require("neo-tree.sources.git_status").refresh()
      end
    end,
  })
end

return M
