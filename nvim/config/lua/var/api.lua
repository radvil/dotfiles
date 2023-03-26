---display a log message on console only for while in a dev mode
---@param msg string
---@param prefix string | nil
_G.Log = function(msg, prefix)
  if not rvim.devmode then
    return
  end
  prefix = prefix or "Log"
  prefix = string.format("[%s]", prefix)
  vim.api.nvim_echo({ { prefix, "Type" }, { " ≫ " .. msg } }, true, {})
end

---display a warning message on console only for while in a dev mode
---@param msg string
---@param prefix string | nil
_G.Warn = function(msg, prefix)
  if not rvim.devmode then
    return
  end
  prefix = prefix or "Warn"
  prefix = string.format("[%s]", prefix)
  vim.api.nvim_echo({ { prefix, "Label" }, { " ≫ " .. msg } }, true, {})
end

---check a given arg whether it is an empty string
---@param arg string
---@return boolean
_G.IsEmpty = function(arg)
  return arg == nil or arg == ""
end

---safety call to retrieve current buffer options
---@param opt string
---@return table | nil
_G.GetBufOpt = function(opt)
  local okay, buf_opt = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not okay then
    return nil
  else
    return buf_opt
  end
end

---check a given path is of type file or not
---@param path string
---@return boolean
_G.IsFile = function(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

---check a given path is a directory or not
---@param path string
---@return boolean
_G.IsDir = function(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

---safety require module
---@param ... any
---@return any | nil
_G.Call = function(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  else
    return nil
  end
end

---merge two table
---@param tbl table
---@param partials table
---@return table
_G.Merge = function(tbl, partials)
  return vim.tbl_extend("force", tbl, partials or {})
end

---merge two list
---@param tbl1 List | nil
---@param tbl2 List | nil
---@return List
_G.MergeIpairs = function(tbl1, tbl2)
  tbl1 = tbl1 or {}
  tbl2 = tbl2 or {}
  for _, value in ipairs(tbl2) do
    table.insert(tbl1, value)
  end
  return tbl1
end

---setup a global keymaping
---@param mode string | table
---@param lhs string
---@param rhs string | function
---@param opts table<string,any> | nil
_G.Map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_deep_extend("force", { silent = true, noremap = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

---setup a keymap to attach to only current buffer
---will be destroyed when buffer is not longer exists
---@param bufnr integer
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table<string,any>| nil
_G.MapBuf = function(bufnr, mode, lhs, rhs, opts)
  opts = vim.tbl_deep_extend("force", { silent = true, noremap = true }, opts or {})
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
end

---check whether current buffer is an empty buffer
---@return boolean
_G.IsBufferNotEmpty = function()
  return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
end

---set the existing highlight group
---@param hlGroup string
---@param opts table | nil
_G.SetHl = function(hlGroup, opts)
  vim.api.nvim_set_hl(0, hlGroup, opts or {})
end

---check whether current file belongs to a git workspace
---@return boolean
_G.IsGitWorkspace = function()
  local filepath = vim.fn.expand("%:p:h")
  local gitdir = vim.fn.finddir(".git", filepath .. ";")
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

---@param list table
---@param item string | number | boolean | table | nil
---@return table<string | number | boolean>
_G.ipairs_excl = function(list, item)
  if item == nil then
    return list
  end
  local ret = {}
  if type(item) == "table" then
    for _, value in ipairs(item) do
      for _, v in ipairs(value) do
        table.insert(ret, v)
      end
    end
  else
    for _, value in ipairs(list) do
      if value ~= item then
        table.insert(ret, value)
      end
    end
  end
  return ret
end

Log("custom api(s) loaded", "var")
