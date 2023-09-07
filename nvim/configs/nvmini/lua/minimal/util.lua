local M = {}

---@param ... any
---@return any | nil
function M.call(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  else
    return nil
  end
end

---@param plugin string
function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

---@param callback fun(client, buffer)
function M.on_lsp_attach(callback)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      callback(client, buffer)
    end,
  })
end

function M.log(msg, opts)
  opts = vim.tbl_deep_extend("force", {
    severity = vim.log.levels.INFO,
    title = "LOG",
  }, opts or {})
  local title = string.format("[%s]", opts.title)
  local hl = opts.severity == vim.log.levels.INFO and "Type" or "Label"
  vim.api.nvim_echo({
    { title, hl },
    { " » " .. msg },
  }, true, {})
end

function M.debug(msg)
  if not minimal.dev then
    return
  end
  local opts = {
    severity = vim.log.levels.INFO,
    title = "DEBUG",
  }
  local title = string.format("[%s]", opts.title)
  vim.api.nvim_echo({
    { title, "Debug" },
    { " » " .. msg },
  }, true, {})
end

function M.map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", {
    noremap = true,
    silent = true,
  }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

local root_pattern_fallback = { ".git", "lua" }

---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local rp = vim.loop.fs_realpath(p)
        if path:find(rp or 0, 1, true) then
          roots[#roots + 1] = rp
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
    root = vim.fs.find(root_pattern_fallback, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
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

    return require("lazy.core.util").info("Set " .. option .. " to " .. vim.opt_local[option]:get(), opt)
  end

  vim.opt_local[option] = not vim.opt_local[option]:get()

  if not silent then
    local opt = { title = "Option" }
    if vim.opt_local[option]:get() then
      require("lazy.core.util").info("Enabled " .. option, opt)
    else
      require("lazy.core.util").warn("Disabled " .. option, opt)
    end
  end
end

---@type table<string,LazyFloat>
local terminals = {}

-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? LazyCmdOptions|{interactive?:boolean, esc_esc?:false, ctrl_hjkl?:false}
function M.float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    ft = "lazyterm",
    size = { width = 0.9, height = 0.9 },
  }, opts or {}, { persistent = true })

  ---@cast opts LazyCmdOptions|{interactive?:boolean, esc_esc?:false}
  local termkey = vim.inspect({ cmd = cmd or "shell", cwd = opts.cwd, env = opts.env, count = vim.v.count1 })

  if terminals[termkey] and terminals[termkey]:buf_valid() then
    terminals[termkey]:toggle()
  else
    terminals[termkey] = require("lazy.util").float_term(cmd, opts)
    local buf = terminals[termkey].buf
    vim.b[buf].lazyterm_cmd = cmd
    if opts.esc_esc == false then
      vim.keymap.set("t", "<esc>", "<esc>", { buffer = buf, nowait = true })
    end
    if opts.ctrl_hjkl == false then
      vim.keymap.set("t", "<c-h>", "<c-h>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<c-j>", "<c-j>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<c-k>", "<c-k>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<c-l>", "<c-l>", { buffer = buf, nowait = true })
    end
    if vim.g.mapleader == " " then
      vim.keymap.set("t", "<space>", " ", { buffer = buf, nowait = true })
    end
    vim.api.nvim_create_autocmd("BufEnter", {
      buffer = buf,
      callback = function()
        vim.cmd.startinsert()
      end,
    })
  end
  return terminals[termkey]
end

---@param name string
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

-- ---@param name string
-- ---@param fn fun(name:string)
-- function M.on_load(name, fn)
--   local Config = require("lazy.core.config")
--   if Config.plugins[name] and Config.plugins[name]._.loaded then
--     vim.schedule(function()
--       fn(name)
--     end)
--   else
--     vim.api.nvim_create_autocmd("User", {
--       pattern = "LazyLoad",
--       callback = function(event)
--         if event.data == name then
--           fn(name)
--           return true
--         end
--       end,
--     })
--   end
-- end

return M
