return {
  "echasnovski/mini.surround",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.silent = true
    opts.respect_selection_type = true
    opts.mappings = {
      add = "-a",
      replace = "-s",
      delete = "-d",
      find_left = "-[",
      find = "-]",
      highlight = "-h",
      update_n_lines = "",
    }
    return opts
  end,
}
