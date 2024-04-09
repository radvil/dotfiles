local feature_name = "Harpoon"

---@param name string custom command name
---@param opts { desc: string, callback: function } custom options
local user_cmd = function(name, opts)
  vim.api.nvim_create_user_command(name, opts.callback, { desc = "[harpoon] " .. opts.desc })
end

local get_buf_filepath = function()
  local opts = LazyVim.opts("harpoon")
  local root = opts.default and opts.default.get_root_config and opts.default.get_root_config() or vim.uv.cwd()
  local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  return require("plenary.path"):new(buf_name):make_relative(root)
end

local append = function()
  local harpoon = require("harpoon")
  local item, index = harpoon:list():get_by_display(get_buf_filepath())
  if not item then
    local list = harpoon:list()
    list:append()
    LazyVim.info("Appended to bookmark as #" .. list:length(), {
      title = feature_name,
      icon = "📌",
    })
  else
    -- Get index of file bookmarked previously
    LazyVim.warn("Already in the bookmark as #" .. index, {
      title = feature_name,
    })
  end
end

local prepend = function()
  local harpoon = require("harpoon")
  local item, index = harpoon:list():get_by_display(get_buf_filepath())
  if not item then
    harpoon:list():prepend()
    LazyVim.info("Prepended to bookmark as #1", {
      title = feature_name,
      icon = "📌",
    })
  else
    LazyVim.warn("Already in the bookmark as #" .. index, {
      title = feature_name,
    })
  end
end

---@type LazySpec
return {
  "radvil/harpoon",
  lazy = true,
  branch = "api/expose-index",
  keys = {
    {
      "<Leader>ma",
      desc = "[a]ppend to bookmark",
      append,
    },
    {
      "<Leader>mi",
      desc = "[i]insert to bookmark",
      prepend,
    },
    {
      [[<Leader>\]],
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = [[toggle bookmark [\]enu]],
    },
    {
      "<leader>[",
      function()
        require("harpoon"):list():prev()
      end,
      desc = "go to prev bookmarked f]le",
    },
    {
      "<leader>]",
      function()
        require("harpoon"):list():next()
      end,
      desc = "go to next bookmarked fi]e",
    },
  },

  ---@type HarpoonConfig
  opts = {
    settings = {
      key = function()
        return vim.uv.cwd() or vim.loop.cwd() or ""
      end,
      save_on_toggle = true,
      sync_on_ui_close = false,
    },
    default = {
      get_root_config = function()
        return vim.uv.cwd()
      end,
    },
    menu = {
      width = vim.api.nvim_win_get_width(0) - 50,
    },
    excluded_filetypes = {
      -- popups
      "TelescopeResults",
      "TelescopePrompt",
      "neo-tree-popup",
      "DressingInput",
      "flash_prompt",
      "cmp_menu",
      "WhichKey",
      "lspinfo",
      "prompt",
      "notify",
      "noice",
      "mason",
      "noice",
      "lazy",
      "oil",

      -- windows
      "NeogitStatus",
      "fugitiveblame",
      "DiffviewFiles",
      "Dashboard",
      "dashboard",
      "gitcommit",
      "MundoDiff",
      "fugitive",
      "NvimTree",
      "neo-tree",
      "Outline",
      "Trouble",
      "dirbuf",
      "prompt",
      "Mundo",
      "alpha",
      "edgy",
      "help",
      "dbui",
      "qf",
    },
  },

  config = function(_, opts)
    local harpoon = require("harpoon")
    harpoon:setup(opts)
    harpoon:extend({
      UI_CREATE = function(ctx)
      --stylua: ignore start
      LazyVim.safe_keymap_set("n", "<C-x>", function() harpoon.ui:select_menu_item({ split = true }) end, { buffer = ctx.bufnr })
      LazyVim.safe_keymap_set("n", "<C-v>", function() harpoon.ui:select_menu_item({ vsplit = true }) end, { buffer = ctx.bufnr })
      LazyVim.safe_keymap_set("n", "<C-t>", function() harpoon.ui:select_menu_item({ tabedit = true }) end, { buffer = ctx.bufnr })
        --stylua: ignore end
      end,
    })
  end,

  init = function()
    user_cmd("HarpoonShowLogs", {
      desc = "show logs",
      callback = function()
        require("harpoon").logger:show()
      end,
    })

    user_cmd("M", {
      desc = "[harpoon] toggle quick menu",
      callback = function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list(), { border = "rounded" })
      end,
    })

    user_cmd("Mnext", {
      desc = "[harpoon] goto next file",
      callback = function()
        require("harpoon"):list():next()
      end,
    })

    user_cmd("Mprev", {
      desc = "[harpoon] goto previous file",
      callback = function()
        require("harpoon"):list():prev()
      end,
    })

    user_cmd("MA", {
      desc = "[harpoon] append to list",
      callback = append,
    })

    user_cmd("MI", {
      desc = "[harpoon] prepend to list",
      callback = prepend,
    })

    for i = 1, 5 do
      user_cmd("M" .. i, {
        desc = "[harpoon] select file #" .. i,
        callback = function()
          require("harpoon"):list():select(i)
        end,
      })
      LazyVim.safe_keymap_set(
        "n",
        "<Leader>" .. i,
        string.format("<cmd>M%s<cr>", i),
        { desc = "go to bookmarked file #" .. i }
      )
    end

    local augroup = vim.api.nvim_create_augroup("NeoHarpoon", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      pattern = "harpoon",
      callback = function()
        vim.cmd("setlocal cursorline")
      end,
    })
  end,
}
