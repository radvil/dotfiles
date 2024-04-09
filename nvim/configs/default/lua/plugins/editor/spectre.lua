local M = {
  "nvim-spectre",
  cmd = "Spectre",
  build = false,
}

M.keys = function()
  return {
    {
      "<leader>sr",
      function()
        require("spectre").open()
      end,
      desc = "[s]pect[r]e",
    },
    {
      "<leader>sw",
      function()
        require("spectre").open_visual({ cwd = vim.uv.cwd(), select_word = true })
      end,
      desc = "[s]pectre in c[w]d",
    },
    {
      "<leader>sw",
      function()
        require("spectre").open_visual({ cwd = vim.uv.cwd(), select_word = true })
      end,
      desc = "[s]pectre in c[w]d",
      mode = { "v", "x" },
    },
    {
      "<leader>sb",
      function()
        require("spectre").open_file_search({ select_word = true })
      end,
      desc = "[s]pectre in current [b]uffer",
    },
    {
      "<leader>sb",
      function()
        require("spectre").open_file_search({ select_word = true })
      end,
      desc = "[s]pectre in current [b]uffer",
      mode = { "v", "x" },
    },
  }
end

M.opts = {
  open_cmd = "noswapfile vnew",
  mapping = {
    ["run_current_replace"] = {
      map = "<Leader>r",
      cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
      desc = "SPECTRE exec » REPLACE current line  ",
    },
    ["run_replace"] = {
      map = "<leader>R",
      cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
      desc = "SPECTRE exec » REPLACE all  ",
    },
    ["send_to_qf"] = {
      map = "<leader>q",
      cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
      desc = "SPECTRE exec » SEND all to quickfix ",
    },
  },
}

return M
