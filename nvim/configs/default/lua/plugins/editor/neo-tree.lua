---@diagnostic disable: param-type-mismatch
return {
  {
    "bufferline.nvim",
    optional = true,
    opts = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            highlight = "NeoBufferLineOffset",
            text_align = "left",
            separator = true,
            --TODO: get current opened dir from neo-tree API 
            text = function()
              local path = vim.fn.getcwd():gsub(os.getenv("HOME"), "~")
              local sep = package.config:sub(1, 1)
              local parts = vim.split(path, "[\\/]")
              if #parts > 4 then
                parts = { parts[1], " … ", parts[#parts - 1], parts[#parts] }
                return "󱉭 " .. table.concat(parts, sep)
              else
                return "󱉭 " .. path
              end
            end,
          },
        },
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "s1n7ax/nvim-window-picker" },

    keys = function()
      return {
        {
          "<Leader>e",
          function()
            require("neo-tree.command").execute({
              dir = LazyVim.root(),
              selector = true,
              reveal = true,
              toggle = true,
            })
          end,
          desc = "[e]xplore tree (root)",
        },
        {
          "<leader>E",
          function()
            require("neo-tree.command").execute({
              dir = vim.uv.cwd(),
              selector = true,
              toggle = true,
            })
          end,
          desc = "[E]xplore tree (cwd)",
        },
        {
          "<leader>fb",
          function()
            require("neo-tree.command").execute({
              dir = LazyVim.root(),
              source = "buffers",
              action = "focus",
              reveal = true,
              toggle = true,
            })
          end,
          desc = "[b]uffers",
        },
        {
          "<Leader>fp",
          function()
            require("neo-tree.command").execute({
              dir = vim.fn.stdpath("data"),
              position = "current",
              selector = false,
              action = "focus",
            })
          end,
          desc = "[p]lugins",
        },
      }
    end,

    opts = function()
      return {
        hide_root_node = true,
        default_component_configs = {
          indent = {
            padding = 3,
            with_markers = true,
            with_expanders = true,
          },
          git_status = {
            symbols = {
              -- Change type
              added = LazyVim.config.icons.git.added,
              deleted = LazyVim.config.icons.git.removed,
              modified = LazyVim.config.icons.git.modified,
              renamed = LazyVim.config.icons.git.renamed,
              -- Status type
              staged = LazyVim.config.icons.git.staged,
              unstaged = LazyVim.config.icons.git.unstaged,
              untracked = LazyVim.config.icons.git.untracked,
              conflict = LazyVim.config.icons.git.conflict,
              ignored = LazyVim.config.icons.git.ignored,
            },
          },
        },

        window = {
          -- width = 40,
          position = "left",
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = false,
            ["l"] = "open",
            ["w"] = "open_with_window_picker",
            ["<cr>"] = "open",
            ["<2-LeftMouse>"] = "open",
            ["<c-v>"] = "open_vsplit",
            ["<c-x>"] = "open_split",
            ["<c-t>"] = "open_tabnew",
            ["<a-cr>"] = "open_tabnew",
            ["h"] = "close_node",
            ["z"] = false,
            ["o"] = false,
            ["za"] = "toggle_node",
            ["zc"] = "close_node",
            ["zM"] = "close_all_nodes",
            ["zR"] = "expand_all_nodes",
            ["r"] = "rename",
            ["<F2>"] = "rename",
            ["?"] = "show_help",
            ["K"] = { "toggle_preview", config = { use_float = true } },
            ["<esc>"] = "revert_preview",
            ["R"] = "refresh",
          },
        },

        filesystem = {
          bind_to_cwd = false,
          use_libuv_file_watcher = true,
          hijack_netrw_behavior = "disabled",
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
          window = {
            mappings = {
              ["."] = "set_root",
              ["/"] = "fuzzy_finder",
              ["H"] = "toggle_hidden",
              ["-"] = "navigate_up",
              ["f"] = "filter_on_submit",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
              ["<a-space>"] = "clear_filter",
              ["a"] = "add",
              ["d"] = "delete",
              ["y"] = "copy_to_clipboard",
              ["p"] = "paste_from_clipboard",
              ["c"] = "copy",
              ["x"] = "cut_to_clipboard",
              ["<space>"] = "none",
              ["Y"] = {
                function(state)
                  local node = state.tree:get_node()
                  local path = node:get_id()
                  vim.fn.setreg("+", path, "c")
                  LazyVim.info("path copied to clipboard!")
                end,
                desc = "copy path to clipboard",
              },
            },
          },
        },

        buffers = {
          show_unloaded = true,
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
          window = {
            mappings = {
              ["d"] = "buffer_delete",
              ["a"] = false,
              ["y"] = false,
              ["p"] = false,
              ["c"] = false,
              ["x"] = false,
            },
          },
        },

        source_selector = {
          winbar = vim.opt.laststatus == 3,
          statusline = vim.opt.laststatus ~= 3,
        },
      }
    end,
  },
}
