---@type LazySpec
return {
  "folke/todo-comments.nvim",
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
        "<leader>/t",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "/ Todo items",
      },
      {
        "<leader>/T",
        function()
          Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "/ items Todo/Fix/Fixme",
      },
    }
  end,
}
