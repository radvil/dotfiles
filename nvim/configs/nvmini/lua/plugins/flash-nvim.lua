---@return NeoFlashFtExcludes
---@param key string
local get_ft = function(key)
  local opts = require("neoverse.utils").opts("flash.nvim")
  if not opts then return {} end
  return opts.neo_filetype_excludes[key] or {}
end

local custom_keys = {
  {
    "<a-space>",
    mode = { "x", "v", "o" },
    function()
      require("flash").treesitter({
        label = {
          rainbow = {
            enabled = true
          }
        },
      })
    end,
    desc = "flash » select node",
  },
  {
    "<a-s>",
    mode = "n",
    function()
      require("flash").treesitter_search({
        label = {
          rainbow = {
            enabled = true
          }
        },
      })
    end,
    desc = "treesitter » search range",
  },
  {
    "go",
    mode = "n",
    function()
      require("flash").jump({
        search = {
          exclude = get_ft("popups"),
          multi_window = true,
          autojump = false,
          forward = true,
        },
        ---@param state Flash.State
        action = function(target, state)
          state:hide()
          vim.api.nvim_set_current_win(target.win)
          vim.api.nvim_win_set_cursor(target.win, target.pos)
          if vim.tbl_contains(get_ft("sidebars"), vim.bo.filetype) then
            vim.cmd.execute([["normal \<CR>"]])
          else
            vim.cmd.execute([["normal gd"]])
          end
        end,
      })
    end,
    desc = "flash » jump and open",
  },
  {
    "<leader>z",
    mode = "n",
    function()
      require("flash").jump({
        search = {
          exclude = get_ft("excludes"),
          multi_window = true,
          autojump = false,
          forward = true,
        },
        ---@param state Flash.State
        action = function(target, state)
          state:hide()
          vim.api.nvim_set_current_win(target.win)
          vim.api.nvim_win_set_cursor(target.win, target.pos)
          vim.cmd.execute([["normal za"]])
          state:restore()
        end,
      })
    end,
    desc = "flash » jump and toggle fold",
  },
}

return {
  "flash.nvim",
  optional = true,
  keys = function(_, keys)
    if type(keys) == "table" then
      vim.list_extend(keys, custom_keys)
    end
  end
}
