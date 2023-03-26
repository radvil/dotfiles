local M = {}
local util = require("lazy.core.util")

---@param plugin string
function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

-- FIXME: create a togglable terminal
-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? LazyCmdOptions|{interactive?:boolean}
function M.float_term(cmd, opts)
  require("lazy.util").float_term(
    cmd,
    Merge(opts or {}, {
      size = {
        width = 0.9,
        height = 0.9,
      },
    })
  )
end

---@param name string
function M.opts(name)
  local pkg = require("lazy.core.config").plugins[name]
  if not pkg then
    return {}
  end
  local plugin = require("lazy.core.plugin")
  return plugin.values(pkg, "opts", false)
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    local opt = { title = "Option" }
    return util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), opt)
  end

  vim.opt_local[option] = not vim.opt_local[option]:get()

  if not silent then
    local opt = { title = "Option" }
    if vim.opt_local[option]:get() then
      util.info("Enabled " .. option, opt)
    else
      util.warn("Disabled " .. option, opt)
    end
  end
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil

  ---@type string[]
  local roots = {}

  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace
          and vim.tbl_map(function(ws)
            return vim.uri_to_fname(ws.uri)
          end, workspace)
        or client.config.root_dir and { client.config.root_dir }
        or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p) or ""
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end

  table.sort(roots, function(a, b)
    return #a > #b
  end)

  ---@type string?
  local root = roots[1]

  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()

    ---@type string?
    root = vim.fs.find(M.root_patterns, {
      path = path,
      upward = true,
    })[1]

    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end

  ---@cast root string
  return root
end

---open an input dialog
---@param opts {title?: string, msg?: string, on_confirmed?: function | nil, on_close?: function | nil }
---@return NuiInput
function M.prompt_confirmation(opts)
  local Input = require("nui.input")
  local options = {
    position = "50%",
    size = { width = 77 },
    win_options = {
      winhighlight = "Normal:Normal",
    },
    border = {
      style = "rounded",
      text = {
        top = string.format(" ≪ %s ≫ ", opts.title or "Confirmation"),
        top_align = "center",
      },
    },
  }
  local inputRef = Input(options, {
    prompt = string.format("💋 %s Y[es]/N[o] == ", opts.msg or "Confirm?"),
    default_value = "No",
    on_submit = function(res)
      local accepted = res == "y" or res == "Y" or res == "Yes" or res == "yes"
      if accepted and type(opts.on_confirmed) == "function" then
        opts.on_confirmed()
        vim.notify("Confirmed!!")
      else
        if type(opts.on_close) == "function" then
          opts.on_close()
          vim.notify("Canceled!")
        end
      end
    end,
    on_close = function()
      Input.on:unmount()
      if type(opts.on_close) == "function" then
        opts.on_close()
      end
    end,
  })
  inputRef:mount()
  local map_opt = { noremap = true, nowait = true }
  inputRef:map("n", "<Esc>", function()
    inputRef:unmount()
  end, map_opt)
  return inputRef
end

-- this will return a function that calls telescope.
-- cwd will defautlt to util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

---find first index of value given
---@param tbl table
---@param value string | boolean | number
---@return number | boolean
function M.tbl_find_findex(tbl, value)
  if type(tbl) ~= "table" then
    error("table expected, got " .. type(tbl), 2)
  end
  local ret = false
  for i, v in pairs(tbl) do
    if value == v then
      ret = i
    end
  end
  return ret
end

---check buffer against given mapping list or string
---@param bufnr integer | nil
---@param mappings table | string
function M.buf_has_keymaps(mappings, mode, bufnr)
  local ret = false
  bufnr = bufnr or 0
  mode = mode or "n"
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return ret
  end
  mappings = (type(mappings) == "table" and mappings) or (type(mappings) == "string" and { mappings }) or {}
  local buf_keymaps = vim.api.nvim_buf_get_keymap(bufnr, mode)
  for _, value in ipairs(mappings) do
    if not not M.tbl_find_findex(buf_keymaps, value) then
      ret = true
      break
    end
  end
  return ret
end

---@alias RvimNotifyOpts {lang?:string, title?:string, level?:number}

---@param msg string|string[]
---@param opts? RvimNotifyOpts
function M.notify(msg, opts)
  if vim.in_fast_event() then
    return vim.schedule(function()
      M.notify(msg, opts)
    end)
  end
  opts = opts or {}
  if type(msg) == "table" then
    msg = table.concat(
      vim.tbl_filter(function(line)
        return line or false
      end, msg),
      "\n"
    )
  end
  local lang = opts.lang or "markdown"
  vim.notify(msg, opts.level or vim.log.levels.INFO, {
    on_open = function(win)
      pcall(require, "nvim-treesitter")
      vim.wo[win].conceallevel = 3
      vim.wo[win].concealcursor = ""
      vim.wo[win].spell = false
      local buf = vim.api.nvim_win_get_buf(win)
      if not pcall(vim.treesitter.start, buf, lang) then
        vim.bo[buf].filetype = lang
        vim.bo[buf].syntax = lang
      end
    end,
    title = opts.title or "rvim",
  })
end

---@param msg string|string[]
---@param opts? RvimNotifyOpts
function M.error(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.ERROR
  M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? RvimNotifyOpts
function M.info(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.INFO
  M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? RvimNotifyOpts
function M.warn(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.WARN
  M.notify(msg, opts)
end

---@param msg string|table
---@param opts? RvimNotifyOpts
function M.debug(msg, opts)
  if not rvim.devmode then
    return
  end
  opts = opts or {}
  if opts.title then
    opts.title = "rvim: " .. opts.title
  end
  if type(msg) == "string" then
    M.notify(msg, opts)
  else
    opts.lang = "lua"
    M.notify(vim.inspect(msg), opts)
  end
end

---@param name string command name
---@return string formatted command
function M.fmtcmd(name)
  return string.format("<Cmd>%s<CR>", name)
end

return M
