return {
  {
    "which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["s"] = { name = "[s]urround" },
      },
    },
  },

  {
    "echasnovski/mini.surround",
    keys = function()
      -- Populate the keys based on the user's options
      local opts = LazyVim.opts("mini.surround")
      local mappings = {
        { opts.mappings.add, desc = "Surround » Open/add", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Surround » Delete" },
        { opts.mappings.find, desc = "Surround » Find next" },
        { opts.mappings.find_left, desc = "Surround » Find prev" },
        { opts.mappings.highlight, desc = "Surround » Highlight" },
        { opts.mappings.replace, desc = "Surround » Replace/subt" },
        { opts.mappings.update_n_lines, desc = "Surround » Update 'n' lines config" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return mappings
    end,
    opts = {
      silent = true,
      respect_selection_type = true,
      mappings = {
        add = "so",
        delete = "sd",
        replace = "sc",
        find_left = "",
        find = "",
        highlight = "sh",
        update_n_lines = "",
      },
    },
  },
}
