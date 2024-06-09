return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = "BufReadPre",
  opts = {
    enable = false,
    mode = "cursor",
    max_lines = 3,
  },
  keys = function()
    return {
      {
        "<leader>ut",
        function()
          local tsc = require("treesitter-context")
          tsc.toggle()
          if LazyVim.inject.get_upvalue(tsc.toggle, "enabled") then
            LazyVim.info("Enabled", { title = "Treesitter Context" })
          else
            LazyVim.warn("Disabled", { title = "Treesitter Context" })
          end
        end,
        desc = "toggle treesitter context",
      },
    }
  end,
}
