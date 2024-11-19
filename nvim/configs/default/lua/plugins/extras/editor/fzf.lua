---@diagnostic disable: assign-type-mismatch, duplicate-doc-field

if true then
  return {}
end

vim.g.lazyvim_picker = "fzf"

---@class FzfLuaOpts: lazyvim.util.pick.Opts
---@field cmd string?

---@type LazyPicker
local picker = {
  name = "fzf",
  commands = {
    files = "files",
  },

  ---@param command string
  ---@param opts? FzfLuaOpts
  open = function(command, opts)
    opts = opts or {}
    if opts.cmd == nil and command == "git_files" and opts.show_untracked then
      opts.cmd = "git ls-files --exclude-standard --cached --others"
    end
    return require("fzf-lua")[command](opts)
  end,
}
if not LazyVim.pick.register(picker) then
  return {}
end

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

local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = require("lazyvim.config").get_kind_filter(ctx.bufnr) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

return {
  desc = "Awesome picker for FZF (alternative to Telescope)",
  recommended = true,
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    opts = function(_, opts)
      local config = require("fzf-lua.config")
      local actions = require("fzf-lua.actions")

      -- Quickfix
      config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
      config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
      config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
      config.defaults.keymap.fzf["ctrl-x"] = "jump"
      config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
      config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

      -- Trouble
      if LazyVim.has("trouble.nvim") then
        config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
      end

      -- Toggle root dir / cwd
      config.defaults.actions.files["ctrl-r"] = function(_, ctx)
        local o = vim.deepcopy(ctx.__call_opts)
        o.root = o.root == false
        o.cwd = nil
        o.buf = ctx.__CTX.bufnr
        LazyVim.pick.open(ctx.__INFO.cmd, o)
      end
      config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
      config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

      -- use the same prompt for all
      local defaults = require("fzf-lua.profiles.default-title")
      local function fix(t)
        t.prompt = t.prompt ~= nil and " " or nil
        for _, v in pairs(t) do
          if type(v) == "table" then
            fix(v)
          end
        end
      end
      fix(defaults)

      local img_previewer ---@type string[]?
      for _, v in ipairs({
        { cmd = "ueberzug", args = {} },
        { cmd = "chafa", args = { "{file}", "--format=symbols" } },
        { cmd = "viu", args = { "-b" } },
      }) do
        if vim.fn.executable(v.cmd) == 1 then
          img_previewer = vim.list_extend({ v.cmd }, v.args)
          break
        end
      end

      return vim.tbl_deep_extend("force", defaults, {
        fzf_colors = true,
        fzf_opts = {
          ["--no-scrollbar"] = true,
        },
        defaults = {
          -- formatter = "path.filename_first",
          formatter = "path.dirname_first",
        },
        previewers = {
          builtin = {
            extensions = {
              ["png"] = img_previewer,
              ["jpg"] = img_previewer,
              ["jpeg"] = img_previewer,
              ["gif"] = img_previewer,
              ["webp"] = img_previewer,
            },
            ueberzug_scaler = "fit_contain",
          },
        },
        -- Custom LazyVim option to configure vim.ui.select
        ui_select = function(fzf_opts, items)
          return vim.tbl_deep_extend("force", fzf_opts, {
            prompt = " ",
            winopts = {
              title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
              title_pos = "center",
            },
          }, fzf_opts.kind == "codeaction" and {
            winopts = {
              layout = "vertical",
              -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
              height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
              width = 0.5,
              preview = {
                layout = "vertical",
                vertical = "down:15,border-top",
              },
            },
          } or {
            winopts = {
              width = 0.5,
              -- height is number of items, with a max of 80% screen height
              height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
            },
          })
        end,
        winopts = {
          width = 0.8,
          height = 0.8,
          row = 0.5,
          col = 0.5,
          preview = {
            scrollchars = { "┃", "" },
          },
        },
        files = {
          cwd_prompt = false,
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
        lsp = {
          symbols = {
            symbol_hl = function(s)
              return "TroubleIcon" .. s
            end,
            symbol_fmt = function(s)
              return s:lower() .. "\t"
            end,
            child_prefix = false,
          },
          code_actions = {
            previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
          },
        },
      })
    end,
    config = function(_, opts)
      require("fzf-lua").setup(opts)
      require("fzf-lua").register_ui_select(opts.ui_select or nil)
    end,
    keys = {
      { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
      { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },

      Kmap("<leader>/m", "<cmd>FzfLua man_pages<cr>", "[m]an pages"),
      Kmap("<leader>/g", "<cmd>FzfLua git_files<cr>", "[g]it files"),
      Kmap("<leader>/b", "<cmd>FzfLua git_branches<cr>", "git [b]ranches"),
      -- Kmap("<leader>/o", "<cmd>Telescope vim_options<cr>", "vim [o]ptions"),
      Kmap("<leader>/:", "<cmd>FzfLua command_history<cr>", "command h[:]story"),
      Kmap("<leader>/c", "<cmd>FzfLua command_history<cr>", "[c]ommands"),
      Kmap("<leader>/X", "<cmd>FzfLua diagnostics_workspace<cr>", "workspace diagnosti[X]"),
      Kmap("<leader>/x", "<cmd>FzfLua diagnostics_document<cr>", "buffer diagnosti[x]"),
      Kmap("<leader>/k", "<cmd>FzfLua keymaps<cr>", "[k]eymaps"),
      Kmap("<leader>/h", "<cmd>FzfLua highlights<cr>", "[h]ighlights"),
      Kmap("<leader>//", "<cmd>FzfLua resume<cr>", "cont[/]nue action"),
      Kmap("<leader>/W", LazyVim.pick("live_grep"), "[W]ord grep (cwd)"),
      Kmap("<leader>/w", LazyVim.pick("live_grep", { root = false }), "[w]ord grep (root)"),
      Kmap("<leader>/f", LazyVim.pick("auto"), "[f]iles (root)"),
      Kmap("<leader>/F", LazyVim.pick("auto", { root = false }), "[F]iles (cwd)"),
      Kmap("<c-p>", LazyVim.pick("auto"), "[p]ick file (root)"),
      Kmap("<f1>", "<cmd>FzfLua help_tags<cr>", "<f1>nd tags"),
      Kmap("<leader>/C", LazyVim.pick("colorschemes"), "[C]olorscheme"),
      Kmap("<leader>/p", LazyVim.pick("auto", { cwd = vim.fn.stdpath("data") }), "[p]lugins"),
      Kmap("<leader>/R", "<cmd>FzfLua oldfiles<cr>", "[R]ecent files (global)"),
      Kmap("<leader>/r", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), "[r]ecent files (cwd)"),
      Kmap("<leader>/s", LazyVim.pick("grep_cword"), "[s]trings grep (root)"),
      Kmap("<leader>/S", LazyVim.pick("grep_cword", { root = false }), "[s]trings grep (cwd)"),
      Kmap("<leader>/s", LazyVim.pick("grep_visual"), "[s]trings grep (root)", "v"),
      Kmap("<leader>/S", LazyVim.pick("grep_visual", { root = false }), "[s]trings grep (cwd)", "v"),
      Kmap("<leader>'", "<cmd>FzfLua marks<cr>", "marks[']"),
      Kmap("<leader>;", "<cmd>FzfLua jumps<cr>", "[;]umplist"),
      Kmap("<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", "buffers (global)"),
      Kmap("<leader>ss", function()
        require("fzf-lua").lsp_document_symbols({ regex_filter = symbols_filter })
      end, "[s]earch document [s]ymbols"),
      Kmap("<leader>s", function()
        require("fzf-lua").lsp_live_workspace_symbols({ regex_filter = symbols_filter })
      end, "[s]earch workspace [s]ymbols"),
    },
  },

  {
    "folke/todo-comments.nvim",
    optional = true,
    keys = {
      {
        "<leader>st",
        function()
          require("todo-comments.fzf").todo()
        end,
        desc = "Todo",
      },
      {
        "<leader>sT",
        function()
          require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(Keys, {
        { "<c-k>", false, mode = "i" },
        { "<leader>cc", false },
        { "<leader>cC", false },
        { "gy", false },
        { "]]", false },
        { "[[", false },
        {
          "g<c-v>",
          function()
            require("fzf-lua").lsp_definitions({
              jump_to_single_result = true,
              ignore_current_line = true,
              winopts = {
                split = "belowright new",
              },
            })
          end,
          desc = "goto [d]efinition (vsplit)",
          has = "definition",
        },

        -- TODO: Finish migration

        {
          "gd",
          "<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>",
          desc = "Goto Definition",
          has = "definition",
        },
        {
          "gr",
          "<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>",
          desc = "References",
          nowait = true,
        },
        {
          "gI",
          "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>",
          desc = "Goto Implementation",
        },
      })
    end,
  },
}
