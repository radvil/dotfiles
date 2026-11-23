local actions_keys = {
  ["<a-c>"] = false,
  ["<a-u>"] = {
    "toggle_cwd",
    mode = { "n", "i" },
  },

  ["<a-space>"] = {
    "close",
    mode = { "n", "i" },
  },
  ["<c-x>"] = {
    "edit_split",
    mode = { "n", "i" },
  },
  ["<c-v>"] = {
    "edit_vsplit",
    mode = { "n", "i" },
  },
  ["<c-t>"] = {
    "edit_tab",
    mode = { "n", "i" },
  },
  ["<a-cr>"] = {
    "pick_win",
    mode = { "n", "i" },
  },

  ["<c-u>"] = {
    "preview_scroll_up",
    mode = { "n", "i" },
  },
  ["<c-d>"] = {
    "preview_scroll_down",
    mode = { "n", "i" },
  },
  ["<a-Up>"] = {
    "layout_top",
    mode = { "n", "i" },
  },
  ["<a-Right>"] = {
    "layout_right",
    mode = { "n", "i" },
  },
  ["<a-Down>"] = {
    "layout_bottom",
    mode = { "n", "i" },
  },
  ["<a-Left>"] = {
    "layout_left",
    mode = { "n", "i" },
  },
}

---@diagnostic disable: assign-type-mismatch
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      win = {
        input = {
          keys = actions_keys,
        },
      },
      actions = {
        ---@param p snacks.Picker
        toggle_cwd = function(p)
          local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
          local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
          local current = p:cwd()
          p:set_cwd(current == root and cwd or root)
          p:find()
        end,
      },
    },
  },
  -- stylua: ignore
  keys = function ()
    return {
      { "<leader>/m", function() Snacks.picker.man() end, desc = "/ Man Pages" },
      { "<leader>/g", function() Snacks.picker.git_files() end, desc = "/ Git files" },
      { "<leader>/c", function() Snacks.picker.commands() end, desc = "/ Commands" },
      { "<leader>/:", function() Snacks.picker.command_history() end, desc = "/ Command History" },
      { "<leader>/X", function() Snacks.picker.diagnostics() end, desc = "/ Diagnostics" },
      { "<leader>/x", function() Snacks.picker.diagnostics_buffer() end, desc = "/ Buffer Diagnostics" },
      { "<leader>/k", function() Snacks.picker.keymaps() end, desc = "/ Keymaps" },
      { "<leader>/h", function() Snacks.picker.highlights() end, desc = "/ Highlights" },
      { "<leader>//", function() Snacks.picker.resume() end, desc = "/ Resume" },
      { "<leader>/F", LazyVim.pick("files"), desc = "/ Files (Root Dir)" },
      { "<c-p>", LazyVim.pick("files", { root = false }), desc = "/ Files (cwd)" },
      { "<leader>/f", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<f1>", function() Snacks.picker.help() end, desc = "/ Help Pages" },
      { "<leader>/W", LazyVim.pick("live_grep", {
        layout = {
          preset = "bottom",
          preview = true,
          layout = {
            width = 0.8,
            height = 0.8
          }
        }
      }), desc = "/ Grep (Root Dir)" },
      { "<leader>/w", LazyVim.pick("live_grep", {
        root = false,
        layout = {
          preset = "bottom",
          preview = true,
          layout = {
            width = 0.8,
            height = 0.5
          }
        }
      }), desc = "/ Grep (cwd)" },
      { "<leader>/C", function() Snacks.picker.colorschemes() end, desc = "/ Colorschemes" },
      { "<leader>/p", function() Snacks.picker.projects({
        focus = "list",
        layout = {
          preview = true,
          layout = {
            height = 0.5,
            width = 0.6,
          }
        }
      }) end, desc = "/ Projects" },
      { "<leader>/P", LazyVim.pick("find_files", { cwd = vim.fn.stdpath("data")}), desc = "/ Plugins" },
      { "<leader>/L", function() Snacks.picker.lazy() end, desc = "/ for Plugin Spec" },
      { "<leader>/R", LazyVim.pick("oldfiles"), desc = "/ Recent" },
      { "<leader>/r", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "/ Recent (cwd)" },
      { "<leader>/D", LazyVim.pick.config_files(), desc = "/ Dotfiles" },
      -- { "<leader>/S", LazyVim.pick("grep"), desc = "Grep (Root Dir)" },
      { "<leader>/S", LazyVim.pick("grep_word"), desc = "/ Selection / word (Root Dir)", mode = { "n", "x" } },
      { "<leader>/s", LazyVim.pick("grep_word", { root = false }), desc = "/ Selection / word (cwd)", mode = { "n", "x" } },
      { "<leader>'", function() Snacks.picker.marks() end, desc = "/ Marks" },
      { "<leader>;", function() Snacks.picker.jumps() end, desc = "/ Jumps" },
      { '<leader>"', function() Snacks.picker.registers({ focus = "list" }) end, desc = "/ Registers" },
      { "<leader>,", function() Snacks.picker.buffers({
        focus = "list",
        layout = {
          preview = false,
          layout = {
            height = 0.4,
            max_width = 80,
          }
        }
      }) end, desc = "/ Buffers" },
      { "<leader><tab>", function() Snacks.picker.buffers({
        focus = "list",
        layout = {
          preset = "right",
          preview = false,
          layout = {
            width = 0.2,
          }
        }
      }) end, desc = "/ Buffers" },
      { "<leader>/b", function() Snacks.picker.buffers({
        focus = "list",
        layout = {
          preset = "bottom",
          preview = true,
          layout = {
            height = 0.4
          }
        }
      }) end, desc = "/ Buffers" },
      { "<leader>/B", function() Snacks.picker.buffers({
        hidden = true,
        nofile = true,
        focus = "list",
        layout = {
          preset = "bottom",
          preview = true,
          layout = {
            height = 0.4
          }
        }
      }) end, desc = "/ Buffers (all)" },
      { "<leader>/n", function() Snacks.picker.notifications({ focus = "list" }) end, desc = "/ Notification History" },
      { "<leader>/l", function() Snacks.picker.loclist() end, desc = "/ Location List" },
      { "<leader>/q", function() Snacks.picker.qflist() end, desc = "/ Quickfix List" },
      { "<leader>/o", function() Snacks.picker.grep_buffers() end, desc = "/g Open Buffers" },
      { "<leader>/a", function() Snacks.picker.autocmds() end, desc = "/ Autocmds" },
      { "<leader>/u", function() Snacks.picker.undo({
        focus = "list",
        layout = {
          preset = "bottom",
          preview = true,
          layout = {
            height = 0.5,
          }
        }
      }) end, desc = "/ Undotree" },
    }
  end,
}
