-- if true then
--   return {}
-- end

---@diagnostic disable: assign-type-mismatch
local Config = require("lazyvim.config")
local Icons = {
  FindSymbols = " ",
  FindHiddens = "󰈈 ",
  FindKeymaps = "󰌌 ",
  FindHighlights = " ",
  FindHelpTags = "󰋖",
  FindFiles = " ",
  ResumeLast = " ",
  LiveGrepWords = "󱀽 ",
  FindColorschemes = " ",
  FindInstalledPlugins = " ",
  FindRecentFiles = " ",
  GrepStrings = " ",
  MarkList = "󰙒 ",
  JumpList = " ",
  Buffers = " ",
}

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local actions = require("telescope.actions")
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.pick("find_files", {
          prompt_title = Icons.FindHiddens .. "files + [i]gnored",
          sorting_strategy = "descending",
          default_text = line,
          no_ignore = true,
        })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.pick("find_files", {
          prompt_title = Icons.FindHiddens .. "files + [h]idden",
          sorting_strategy = "descending",
          default_text = line,
          hidden = true,
        })()
      end
      local mappings = {
        ["<a-space>"] = actions.close,
        ["<cr>"] = actions.select_default,
        ["<c-y>"] = actions.select_default,
        ["<c-v>"] = actions.select_vertical,
        ["<c-x>"] = actions.select_horizontal,
        ["<a-cr>"] = actions.select_tab,
        ["<c-t>"] = actions.select_tab,
        ["<c-p>"] = actions.move_selection_previous,
        ["<c-n>"] = actions.move_selection_next,
        ["<a-j>"] = actions.cycle_history_next,
        ["<a-k>"] = actions.cycle_history_prev,
        ["<c-u>"] = actions.preview_scrolling_up,
        ["<c-d>"] = actions.preview_scrolling_down,
        ["<a-i>"] = find_files_no_ignore,
        ["<a-h>"] = find_files_with_hidden,
      }
      local NeoDefaults = {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "bottom",
            width = 0.9,
            height = 0.9,
          },

          -- create_layout = require("fuse").create_fused_layout,
          -- layout_strategy = "flex",
          -- layout_config = {
          --   horizontal = {
          --     size = {
          --       width = "90%",
          --       height = "80%",
          --     },
          --   },
          --   vertical = {
          --     size = {
          --       width = "90%",
          --       height = "90%",
          --     },
          --   },
          -- },

          sorting_strategy = "ascending",
          prompt_prefix = " 🔭 ",
          selection_caret = "👉",
          mappings = {
            ["i"] = mappings,
            ["n"] = vim.tbl_extend("force", mappings, {
              ["<esc>"] = actions.close,
              ["q"] = actions.close,
            }),
          },
        },
      }
      if vim.g.neo_winborder == "single" then
        NeoDefaults.defaults.borderchars = {
          "─",
          "│",
          "─",
          "│",
          "┌",
          "┐",
          "┘",
          "└",
        }
      end
      return NeoDefaults
    end,
    keys = function()
      ---@param lhs string
      ---@param cmd string | function
      ---@param desc string
      ---@param mode? "n" | "v"
      local Kmap = function(lhs, cmd, desc, mode)
        return {
          lhs,
          cmd,
          desc = desc,
          mode = mode or "n",
        }
      end
      return {
        Kmap("<leader>/m", "<cmd>Telescope man_pages<cr>", "[m]an pages"),
        Kmap("<leader>/g", "<cmd>Telescope git_files<cr>", "[g]it files"),
        Kmap("<leader>/b", "<cmd>Telescope git_branches<cr>", "git [b]ranches"),
        Kmap("<leader>/o", "<cmd>Telescope vim_options<cr>", "vim [o]ptions"),
        Kmap("<leader>/:", "<cmd>Telescope command_history<cr>", "command h[:]story"),
        Kmap("<leader>/c", "<cmd>Telescope commands<cr>", "[c]ommands"),
        Kmap("<leader>/X", "<cmd>Telescope diagnostics<cr>", "workspace diagnosti[X]"),
        Kmap("<leader>/x", "<cmd>Telescope diagnostics bufnr=0<cr>", "buffer diagnosti[x]"),
        Kmap("<leader>/k", LazyVim.pick("keymaps", { prompt_title = Icons.FindKeymaps .. "[k]eymaps" }), "[k]eymaps"),

        Kmap(
          "<leader>/h",
          LazyVim.pick("highlights", { prompt_title = Icons.FindHighlights .. "[h]ighlights" }),
          "[h]ighlights"
        ),

        Kmap(
          "<leader>//",
          LazyVim.pick("resume", { prompt_title = Icons.ResumeLast .. "cont[/]nue action" }),
          "cont[/]nue action"
        ),
        Kmap("<leader>/f", LazyVim.pick("files", { prompt_title = Icons.FindFiles .. "[f]iles" }), "[f]iles (root)"),
        Kmap(
          "<leader>/F",
          LazyVim.pick("files", {
            prompt_title = Icons.FindFiles .. "[F]iles",
            cwd = vim.uv.cwd(),
          }),
          "[F]iles (cwd)"
        ),

        {
          "<leader>bs",
          function()
            require("telescope.builtin").lsp_document_symbols({
              prompt_title = Icons.FindSymbols .. "[b]uffer [s]ymbols",
              symbols = Config.get_kind_filter(),
            })
          end,
          desc = "[b]uffer [s]ymbols",
        },

        {
          "<c-p>",
          LazyVim.pick("files", { prompt_title = Icons.FindFiles .. "[p]ick file" }),
          desc = "[p]ick file (root)",
        },

        {
          "<f1>",
          LazyVim.pick("help_tags", { prompt_title = Icons.FindHelpTags .. " <f1>nd tags" }),
          desc = "<f1>nd tags",
        },

        Kmap(
          "<leader>/w",
          LazyVim.pick("live_grep", {
            prompt_title = Icons.LiveGrepWords .. "[w]ord grep",
            layout_strategy = "vertical",
          }),
          "[w]ord grep (root)"
        ),

        Kmap(
          "<leader>/W",
          LazyVim.pick("live_grep", {
            prompt_title = Icons.LiveGrepWords .. "[W]ord grep",
            layout_strategy = "vertical",
            cwd = vim.uv.cwd(),
          }),
          "[W]ord grep (cwd)"
        ),

        Kmap(
          "<leader>/C",
          LazyVim.pick("colorscheme", {
            prompt_title = Icons.FindColorschemes .. "[C]olorscheme",
            enable_preview = true,
          }),
          "[C]olorscheme"
        ),

        Kmap(
          "<leader>/p",
          LazyVim.pick("find_files", {
            prompt_title = Icons.FindInstalledPlugins .. "[p]lugins",
            cwd = vim.fn.stdpath("data"),
          }),
          "[p]lugins"
        ),

        Kmap(
          "<leader>/r",
          LazyVim.pick("oldfiles", {
            prompt_title = Icons.FindRecentFiles .. "[r]ecent files (cwd)",
            initial_mode = "normal",
            cwd = vim.uv.cwd(),
          }),
          "[r]ecent files (cwd)"
        ),

        Kmap(
          "<leader>/R",
          LazyVim.pick("oldfiles", {
            prompt_title = Icons.FindRecentFiles .. "[R]ecent files (global)",
            initial_mode = "normal",
            cwd = false,
          }),
          "[R]ecent files"
        ),

        Kmap(
          "<leader>/s",
          LazyVim.pick("grep_string", {
            prompt_title = Icons.GrepStrings .. "[s]trings grep",
            layout_strategy = "vertical",
          }),
          "[s]trings grep (root)"
        ),

        Kmap(
          "<leader>/s",
          LazyVim.pick("grep_string", {
            prompt_title = Icons.GrepStrings .. "[s]trings grep selection",
            layout_strategy = "vertical",
            mode = "v",
          }),
          "[s]trings grep selection (root)",
          "v"
        ),

        Kmap(
          "<leader>/S",
          LazyVim.pick("grep_string", {
            prompt_title = Icons.GrepStrings .. "[S]trings grep",
            layout_strategy = "vertical",
            cwd = vim.uv.cwd(),
          }),
          "[S]trings grep (cwd)"
        ),

        Kmap(
          "<leader>/S",
          LazyVim.pick("grep_string", {
            prompt_title = Icons.GrepStrings .. "[S]tring grep selection",
            layout_strategy = "vertical",
            cwd = vim.uv.cwd(),
          }),
          "[S]tring grep selection [cwd]",
          "v"
        ),

        {
          "<leader>'",
          LazyVim.pick("marks", {
            prompt_title = Icons.MarkList .. "marks[']",
            initial_mode = "normal",
          }),
          desc = "marks[']",
        },

        {
          "<leader>;",
          LazyVim.pick("jumplist", {
            prompt_title = Icons.JumpList .. "[;]umplist",
            initial_mode = "normal",
          }),
          desc = "[;]umplist",
        },

        {
          "<leader><tab>",
          LazyVim.pick("buffers", {
            prompt_title = Icons.FindRecentFiles .. "buffers (cwd)",
            ignore_current_buffer = false,
            initial_mode = "normal",
            cwd = vim.uv.cwd(),
            sort_mru = true,
          }),
          desc = "buffers (cwd)",
        },

        {
          "<leader>,",
          LazyVim.pick("buffers", {
            prompt_title = Icons.Buffers .. "buffers (global)",
            ignore_current_buffer = false,
            initial_mode = "normal",
            sort_lastused = true,
            sort_mru = true,
            cwd = false,
          }),
          desc = "buffers (global)",
        },
      }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(Keys, {
        {
          "g<c-v>",
          function()
            require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
          end,
          desc = "Go to Definition (vsplit)",
          has = "definition",
        },
        {
          "g<c-x>",
          function()
            require("telescope.builtin").lsp_definitions({ jump_type = "split" })
          end,
          desc = "Go to Definition (split)",
          has = "definition",
        },
        {
          "g<c-t>",
          function()
            require("telescope.builtin").lsp_definitions({ jump_type = "tab drop" })
          end,
          desc = "Go to Definition (tab drop)",
          has = "definition",
        },
        {
          "<a-k>",
          vim.lsp.buf.signature_help,
          mode = "i",
          desc = "Signature Help",
          has = "signatureHelp",
        },
        {
          "K",
          function()
            local ufo = LazyVim.has("nvim.ufo")
            if ufo then
              return require("ufo").peekFoldedLinesUnderCursor() or vim.lsp.buf.hover()
            else
              return vim.lsp.buf.hover()
            end
          end,
          desc = "Hover",
          has = "hover",
        },
      })
    end,
  },
}
