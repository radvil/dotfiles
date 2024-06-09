return {
  "stevearc/oil.nvim",
  optional = true,
  opts = function(_, opts)
    if type(opts.keymaps) == "table" then
      local actions = require("oil.actions")
      -- new tab and close previous opened oil window
      local newtab = function()
        local bufnr = vim.api.nvim_get_current_buf()
        actions.select_tab.callback()
        vim.schedule(function()
          vim.api.nvim_buf_delete(bufnr, {})
        end)
      end
      opts.keymaps["<a-cr>"] = newtab
      opts.keymaps["<c-t>"] = newtab
    end
  end,
}
