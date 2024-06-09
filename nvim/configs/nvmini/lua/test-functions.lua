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
  -- vim.print(vim.fn.stdpath("state"))
  -- M.debug_plugins()
  -- local active_clients = Lonard.lsp.get_clients();
  -- vim.print(active_clients[1].config.filetypes)

  vim.print(vim.fn.system("which ngserver"))
end

M.main()

return M
