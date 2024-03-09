return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "BufReadPost",
  enabled = true,
  config = true,
  keys = function()
    return {
      {
        "]x",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "TODO » Next ref",
      },
      {
        "[x",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "TODO » Prev ref",
      },
      {
        "<leader>xt",
        ":TodoTrouble<Cr>",
        desc = "Diagnostics » Todo comments",
      },
      {
        "<leader>/t",
        ":TodoTelescope<Cr>",
        desc = "Telescope » Find tasks",
      },
    }
  end,
}
