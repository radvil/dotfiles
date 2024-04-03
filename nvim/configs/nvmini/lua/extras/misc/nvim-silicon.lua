return {
  "michaelrommel/nvim-silicon",
  desc = "Highlight and take screenshot of your code",
  cmd = "Silicon",
  lazy = true,
  keys = {
    {
      "<leader>cS",
      ":Silicon<cr>",
      desc = "Code screenshot",
      mode = { "v", "n" },
    },
  },
  opts = {
    ---see silicon --config=file,
    disable_defaults = false,
    to_clipboard = true,
    font = "JetBrainsMono Nerd Font=36;Noto Color Emoji=36",
    theme = "Nord",
    background = "#3b4252",
    shadow_color = "#4c566a",
    shadow_blur_radius = 18,
    line_pad = 1,
    pad_horiz = 180,
    pad_vert = 180,
    no_window_controls = false,
    language = function()
      return vim.bo.filetype
    end,
    window_title = function()
      return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
    end,
  },
}
