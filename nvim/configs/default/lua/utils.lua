local M = {}

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
    if not not vim.tbl_contains(buf_keymaps, value) then
      ret = true
      break
    end
  end
  return ret
end

---@param ... any
---@return any | false
function M.call(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  else
    return false
  end
end


local lsp_priority = {
  rename = {
    "angularls",
    "vtsls",
    "html",
  },
}

-- https://neovim.io/doc/user/lsp.html#lsp-api
local lsp_have_feature = {
  rename = function(client)
    return client.supports_method("textDocument/rename")
  end,
  inlay_hint = function(client)
    return client.supports_method("textDocument/inlayHint")
  end,
}

local function lsp_buf_rename(client_name)
  vim.lsp.buf.rename(nil, { name = client_name })
end

local function get_lsp_client_names(have_feature)
  local client_names = {}
  local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, client in ipairs(attached_clients) do
    if have_feature(client) then
      table.insert(client_names, client.name)
    end
  end
  return client_names
end

local function lsp_buf_rename_use_any(fallback)
  local client_names = get_lsp_client_names(lsp_have_feature.rename)
  for _, client_name in ipairs(client_names) do
    lsp_buf_rename(client_name)
    return
  end
  if fallback then
    fallback()
  end
end

function M.lsp_buf_rename_use_one(fallback)
  local client_names = get_lsp_client_names(lsp_have_feature.rename)
  if #client_names == 1 then
    lsp_buf_rename(client_names[1])
    return
  end
  if fallback then
    fallback()
  end
end

function M.lsp_buf_rename_use_priority(fallback)
  local client_names = get_lsp_client_names(lsp_have_feature.rename)
  for _, client_priority_name in ipairs(lsp_priority.rename) do
    for _, client_name in ipairs(client_names) do
      if client_priority_name == client_name then
        lsp_buf_rename(client_priority_name)
        return
      end
    end
  end
  if fallback then
    fallback()
  end
end

function M.lsp_buf_rename_use_priority_or_any()
  M.lsp_buf_rename_use_one(function()
    M.lsp_buf_rename_use_priority(function()
      lsp_buf_rename_use_any()
    end)
  end)
end

return M
