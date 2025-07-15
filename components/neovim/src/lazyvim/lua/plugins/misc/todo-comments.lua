---@type LazySpec
return {
  "todo-comments.nvim",
  keys = function()
    return {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "goto next [t]odo",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "goto previous [t]odo",
      },
      {
        "<leader>xt",
        "<cmd>TodoTrouble<Cr>",
        desc = "[t]odos diagnosti[x]",
      },
      {
        "<leader>/t",
        "<cmd>TodoTelescope<Cr>",
        desc = "telescope » [t]asks/[t]odos",
      },
    }
  end,
}
