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

M.main = function()
  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = "*",
  --   callback = function()
  --     vim.notify(vim.bo.filetype)
  --   end,
  -- })
end

M.main()

return M
