return {
  "echasnovski/mini.bufremove",
  keys = function()
    return {
      {
        "<Leader>bd",
        "<cmd>BD<cr>",
        desc = "[d]elete buffer",
      },
      {
        "<Leader>bf",
        "<cmd>BF<cr>",
        desc = "[f]orce delete buffer",
      },
      {
        "<Leader>bD",
        "<cmd>BAD<cr>",
        desc = "[D]elete buffers",
      },
      {
        "<Leader>bF",
        "<cmd>BAF<cr>",
        desc = "[F]orce delete buffers",
      },
    }
  end,

  init = function()
    vim.api.nvim_create_user_command("BD", function()
      require("mini.bufremove").delete(0, false)
    end, { desc = "delete current buffer" })

    vim.api.nvim_create_user_command("BAD", function()
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].buftype == "" then
          require("mini.bufremove").delete(bufnr, false)
        end
      end
    end, { desc = "delete all buffers" })

    vim.api.nvim_create_user_command("BF", function()
      require("mini.bufremove").delete(0, true)
    end, { desc = "delete current buffer [force]" })

    vim.api.nvim_create_user_command("BAF", function()
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].buftype == "" then
          require("mini.bufremove").delete(bufnr, true)
        end
      end
    end, { desc = "remove all buffers [force]" })
  end,
}
