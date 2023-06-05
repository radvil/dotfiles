---@diagnostic disable: need-check-nil, undefined-field

local M = {}

M.custom_labels = {
  ["angularls"] = "Angular 2+",
  ["tsserver"] = "Typescript",
  ["lua_ls"] = "Lua",
}

function M.fg(name)
  ---@type {foreground?:number}?
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  local fg = hl and hl.fg or hl.foreground
  return fg and { fg = string.format("#%06x", fg) }
end

---@param opt string
---@return table | nil
function M.get_buf_opt(opt)
  local okay, buf_opt = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not okay then
    return nil
  else
    return buf_opt
  end
end

function M.get_filesize()
  local file = vim.fn.expand("%:p")
  if file == nil or #file == 0 then
    return ""
  end
  local size = vim.fn.getfsize(file)
  if size <= 0 then
    return ""
  end
  local suffixes = { "b", "k", "m", "g" }
  local i = 1
  while size > 1024 and i < #suffixes do
    size = size / 1024
    i = i + 1
  end
  local format = i == 1 and "%d%s" or "%.1f%s"
  local fsize = string.format(format, size, suffixes[i])
  return " 🎲 " .. fsize
end

function M.get_filename()
  local prefix = " ⚓ "
  if M.get_buf_opt("mod") then
    prefix = " 💋 "
  end
  return prefix .. vim.fn.expand("%:t")
end

function M.get_server_name()
  local buffer_ft = M.get_buf_opt("filetype")
  local active_clients = vim.lsp.get_active_clients()
  if next(active_clients) ~= nil then
    for _, client in ipairs(active_clients) do
      local file_type = client.config.filetypes
      if file_type and vim.fn.index(file_type, buffer_ft) ~= -1 then
        return M.custom_labels[client.name] or client.name
      end
    end
  end
  return "No Lsp attached"
end

---@param name? string file name
---@param ext? string file extension
function M.get_filemeta(name, ext)
  local icon = ""
  local color = require("common.colors").bg
  if require("nvim-web-devicons").has_loaded() then
    ext = ext or vim.fn.expand("%:e")
    name = name or vim.fn.expand("%:t")
    icon, color = require("nvim-web-devicons").get_icon_color(name, ext)
  end
  return { icon = icon, color = color }
end

---@param group string highlight groyp
---@param opts {content: string; fg: string; bg: string; bold:boolean; padding: string}
---@return string -- formatted name
function M.create_hi(group, opts)
  local pad = opts.padding or ""
  local hi_group = string.format("NgVimHiStatusline%s", group)
  local content = pad .. opts.content .. pad
  vim.api.nvim_set_hl(0, hi_group, {
    bold = opts.bold or false,
    fg = opts.fg,
    bg = opts.bg,
  })
  return "%#" .. hi_group .. "#" .. content
end

---check whether current buffer is an empty buffer
---@return boolean
function M.is_not_empty_buffer()
  return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
end

---check whether current file belongs to a git workspace
---@return boolean
function M.is_git_workspace()
  local filepath = vim.fn.expand("%:p:h")
  local gitdir = vim.fn.finddir(".git", filepath .. ";")
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

return M
