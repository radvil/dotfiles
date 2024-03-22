local M = {}

M.test_input = function()
  vim.ui.input({
    prompt = "Note title: ",
    completion = "file_in_path", -- :h command-completion
    default = "",
  }, function(value)
    if not value then
      vim.notify("Note creation canceled", vim.log.levels.WARN, {
        title = "Obsidian",
        icon = "󱙒 ",
      })
    else
      vim.cmd("ObsidianNew " .. value)
      -- no need extra notification here since obsidian.nvim has already handled this
    end
  end)
end

M.image_nvim = function()
  package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
  package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

  vim.opt.number = true
  vim.opt.conceallevel = 2
  vim.opt.winbar = "image.nvim demo"
  vim.opt.signcolumn = "yes:2"

  local content = [[
# Hello World

![This is a remote image](https://gist.ro/s/remote.png)
]]

  vim.schedule(function()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, vim.split(content, "\n"))
    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    vim.api.nvim_set_current_buf(buf)
    vim.cmd("split")
  end)
end

M.find_filepath = function()
  local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
  -- vim.notify(fpath) -- ~/.dotfiles/nvim/configs/nvmini/lua
  local basename = vim.fs.basename(fpath)
  vim.notify(basename) -- ~/.dotfiles/nvim/configs/nvmini/lua
end

M.debug_plugins = function()
  local nsn = vim.api.nvim_get_namespaces()
  local counts = {}
  for name, ns in pairs(nsn) do
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local count = #vim.api.nvim_buf_get_extmarks(buf, ns, 0, -1, {})
      if count > 0 then
        counts[#counts + 1] = {
          name = name,
          buf = buf,
          count = count,
          ft = vim.bo[buf].ft,
        }
      end
    end
  end
  table.sort(counts, function(a, b)
    return a.count > b.count
  end)
  vim.print(counts)
end

M.main = function()
  -- vim.print(vim.uv.os_uname());
  M.debug_plugins()
end

M.main()

return M
