if false then
  return {}
end

---@type LazySpec[]
return {
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      {
        "m",
        function()
          require("leap").leap({
            target_windows = {
              vim.fn.win_getid()
            }
          })
        end,
        desc = "Leap » Accross current window",
        mode = { "n", "x", "o" },
      },
      {
        "<a-w>",
        function()
          require('leap').leap {
            target_windows = vim.tbl_filter(
              function(win) return vim.api.nvim_win_get_config(win).focusable end,
              vim.api.nvim_tabpage_list_wins(0)
            )
          }
        end,
        desc = "Leap » Accross all windows",
        mode = "n",
      },
    },
    config = function()
      local leap = require("leap")
      leap.opts.case_sensitive = false
      -- NOTE: IDK why I need these
      leap.opts.special_keys = {
        repeat_search = '<enter>',
        next_phase_one_target = '<enter>',
        next_target = { '<enter>', ';' },
        prev_target = { '<tab>', ',' },
        multi_revert = '<backspace>',
        multi_accept = '<enter>',
        next_group = '<space>',
        prev_group = '<tab>',
      }
    end
  },
  {
    "ggandor/flit.nvim",
    dependencies = "ggandor/leap.nvim",
    config = function()
      local opts = {
        keys = { f = ']f', F = '[f', t = ']t', T = '[t' },
        labeled_modes = "nxo",
      }
      require("flit").setup(opts)
    end
  }
}
