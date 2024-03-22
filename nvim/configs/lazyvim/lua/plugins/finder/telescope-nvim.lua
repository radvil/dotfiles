local Icons = {
  FindHiddens = "󰈈 ",
  FindNotes = "󱙓 ",
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

---@param lhs string
---@param cmd string | function
---@param desc string
local Kmap = function(lhs, cmd, desc)
  return {
    lhs,
    cmd,
    desc = string.format("Telescope » %s", desc),
  }
end

function _G.NeoTelescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    local Root = require("lazyvim.util.root")
    builtin = params.builtin
    opts = params.opts
    ---@type table
    opts = vim.tbl_deep_extend("force", { cwd = Root.get() }, opts or {})
    if builtin == "files" then
      if vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    if opts.cwd and opts.cwd ~= vim.uv.cwd() then
      opts.attach_mappings = function(_, map)
        map("i", "<a-c>", function()
          local action_state = require("telescope.actions.state")
          local line = action_state.get_current_line()
          NeoTelescope(
            params.builtin,
            vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
          )()
        end)
        return true
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",

  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },

  config = function(_, opts)
    local actions = require("telescope.actions")
    local basics = {
      ["<c-t>"] = actions.select_tab,
      ["<c-p>"] = actions.move_selection_previous,
      ["<c-n>"] = actions.move_selection_next,
      ["<c-h>"] = actions.select_horizontal,
      ["<c-v>"] = actions.select_vertical,
      ["<a-d>"] = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        NeoTelescope("find_files", {
          prompt_title = Icons.FindHiddens .. "Find files (no hidden)",
          sorting_strategy = "descending",
          default_text = line,
          no_ignore = true,
          hidden = true,
        })()
      end,
    }

    opts = vim.tbl_deep_extend("force", opts or {}, {
      defaults = {
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        prompt_prefix = " 🔭 ",
        selection_caret = "👉",
        layout_config = {
          prompt_position = "top",
          width = 0.9,
        },
        mappings = {
          ["i"] = vim.tbl_extend("force", basics, {
            ["<a-space>"] = actions.close,
            ["<cr>"] = actions.select_default,
            ["<a-j>"] = actions.cycle_history_next,
            ["<a-k>"] = actions.cycle_history_prev,
            ["<c-d>"] = actions.preview_scrolling_down,
            ["<c-u>"] = actions.preview_scrolling_up,
          }),
          ["n"] = vim.tbl_extend("force", basics, {
            ["q"] = actions.close,
            ["<esc>"] = actions.close,
            ["<a-space>"] = actions.close,
            ["<c-p>"] = actions.move_selection_previous,
            ["<c-n>"] = actions.move_selection_next,
            ["<c-h>"] = actions.select_horizontal,
            ["<c-v>"] = actions.select_vertical,
          }),
        },
      },
    })

    if not string.match(vim.g.colors_name, "catppuccin") then
      opts.defaults.borderchars = {
        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
        preview = { "─", " ", " ", " ", "─", "─", " ", " " },
        results = { " " },
      }
    end

    require("telescope").setup(opts)
  end,

  init = function()
    ---register telescope dotfiles on VimEnter here
    vim.api.nvim_create_user_command("NeoDotfiles", function()
      NeoTelescope("files", {
        prompt_title = "🔧 DOTFILES",
        cwd = os.getenv("DOTFILES"),
      })()
    end, { desc = "Telescope » Open dotfiles" })

    ---register custom note trigger
    vim.api.nvim_create_user_command("NeoNotes", function()
      local note_dir = require("preferences").note_dir
      NeoTelescope("find_files", {
        prompt_title = Icons.FindNotes .. "Find notes",
        cwd = (type(note_dir) == "function" and note_dir()) or note_dir,
      })()
    end, { desc = "Telescope » Find notes" })
  end,

  keys = function()
    return {
      Kmap("<leader>/N", ":NeoNotes<cr>", "Find notes"),
      Kmap("<leader>/d", ":NeoDotfiles<cr>", "Find dotfiles"),
      Kmap("<leader>/m", ":Telescope man_pages<cr>", "Find man pages"),
      Kmap("<leader>/g", ":Telescope git_branches<cr>", "Git branches"),
      Kmap("<leader>/o", ":Telescope vim_options<cr>", "Find vim options"),
      Kmap("<leader>/:", ":Telescope command_history<cr>", "Command history"),
      Kmap("<leader>/c", ":Telescope commands<cr>", "Find available commands"),
      Kmap("<leader>/X", ":Telescope diagnostics<cr>", "Workspace diagnostics"),
      Kmap("<leader>/x", ":Telescope diagnostics bufnr=0<cr>", "Find diagnostics (cwd)"),

      Kmap(
        "<leader>/k",
        NeoTelescope("keymaps", {
          prompt_title = Icons.FindKeymaps .. "Keymaps",
        }),
        "Find keymaps"
      ),

      Kmap(
        "<leader>/H",
        NeoTelescope("highlights", {
          prompt_title = Icons.FindHighlights .. "Highlights",
        }),
        "Find highlights"
      ),

      Kmap(
        "<f1>",
        NeoTelescope("help_tags", {
          prompt_title = Icons.FindHelpTags .. " Help tags",
        }),
        "Find help tags"
      ),

      Kmap(
        "<leader>//",
        NeoTelescope("resume", {
          prompt_title = Icons.ResumeLast .. "Continue",
        }),
        "Continue last action"
      ),

      Kmap(
        "<c-p>",
        NeoTelescope("find_files", {
          prompt_title = Icons.FindFiles .. "Files (cwd)",
        }),
        "Find files (cwd)"
      ),

      Kmap(
        "<leader>/f",
        NeoTelescope("find_files", {
          prompt_title = Icons.FindFiles .. "Files (root)",
          cwd = false,
        }),
        "Find files (root)"
      ),

      Kmap(
        "<leader>/w",
        NeoTelescope("live_grep", {
          prompt_title = Icons.LiveGrepWords .. "Live grep word (cwd)",
          layout_strategy = "vertical",
        }),
        "Live grep word (cwd)"
      ),

      Kmap(
        "<leader>/W",
        NeoTelescope("live_grep", {
          prompt_title = Icons.LiveGrepWords .. "Live grep word (root)",
          layout_strategy = "vertical",
          cwd = false,
        }),
        "Live grep word (root)"
      ),

      Kmap(
        "<leader>/C",
        NeoTelescope("colorscheme", {
          prompt_title = Icons.FindColorschemes .. "Colorscheme",
          enable_preview = true,
        }),
        "Colorscheme"
      ),

      Kmap(
        "<leader>/p",
        NeoTelescope("find_files", {
          prompt_title = Icons.FindInstalledPlugins .. "Find installed plugins",
          cwd = vim.fn.stdpath("data"),
        }),
        "Find installed plugins"
      ),

      Kmap(
        "<leader><tab>",
        NeoTelescope("oldfiles", {
          prompt_title = Icons.FindRecentFiles .. "Recent files (cwd)",
          initial_mode = "normal",
          cwd = vim.uv.cwd(),
        }),
        "Recent files (cwd)"
      ),

      Kmap(
        "<leader>/r",
        NeoTelescope("oldfiles", {
          prompt_title = Icons.FindRecentFiles .. "Recent files (cwd)",
          cwd = vim.uv.cwd(),
        }),
        "Recent files (cwd)"
      ),

      Kmap(
        "<leader>/R",
        NeoTelescope("oldfiles", {
          prompt_title = Icons.FindRecentFiles .. "Recent files (root)",
          initial_mode = "normal",
        }),
        "Most recent used (root)"
      ),

      Kmap(
        "<leader>/S",
        NeoTelescope("grep_string", {
          prompt_title = Icons.GrepStrings .. "Grep strings",
          layout_strategy = "vertical",
        }),
        "Grep strings (cwd)"
      ),

      Kmap(
        "<leader>/s",
        NeoTelescope("grep_string", {
          prompt_title = Icons.GrepStrings .. "Grep string",
          layout_strategy = "vertical",
          cwd = false,
        }),
        "Grep strings (root)"
      ),

      Kmap(
        "<leader>'",
        NeoTelescope("marks", {
          prompt_title = Icons.MarkList .. "Mark list",
          initial_mode = "normal",
        }),
        "Mark list"
      ),

      Kmap(
        "<leader>;",
        NeoTelescope("jumplist", {
          prompt_title = Icons.JumpList .. "Jump list",
          initial_mode = "normal",
        }),
        "Jump list"
      ),

      Kmap(
        "<leader>,",
        NeoTelescope("buffers", {
          prompt_title = Icons.Buffers .. "Other buffers",
          ignore_current_buffer = true,
          initial_mode = "normal",
          sort_lastused = true,
          sort_mru = true,
        }),
        "Other buffers"
      ),
    }
  end,
}
