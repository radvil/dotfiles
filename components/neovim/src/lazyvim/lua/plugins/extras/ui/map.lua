return {
  "echasnovski/mini.map",
  keys = {
    {
      "<leader>um",
      function()
        require("mini.map").toggle()
      end,
      desc = "mini[m]ap",
    },
    {
      "<leader>mm",
      function()
        LazyVim.warn("deprecated. Use <Leader>ww or <a-w> instead!", { title = "mini.map" })
        vim.schedule(function()
          require("mini.map").toggle_focus()
        end)
      end,
      desc = "focus/leave mini[m]ap",
    },
  },
  opts = function()
    local map = require("mini.map")
    return {
      integrations = {
        map.gen_integration.gitsigns(),
        map.gen_integration.diagnostic(),
        map.gen_integration.builtin_search(),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot("3x2"),
      },
      window = {
        focusable = false,
        side = "right",
        winblend = 0,
        zindex = 10,
        width = 20,
      },
    }
  end,
}
