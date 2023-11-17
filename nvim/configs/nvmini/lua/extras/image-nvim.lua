return {
  "3rd/image.nvim",
  ft = { "markdown", "norg", "oil" },
  opts = {
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" },
      },
      neorg = {
        enabled = false,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "norg" },
      },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
    editor_only_render_when_focused = true,
    tmux_show_only_in_active_window = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
  },
  config = function(_, opts)
    -- local has_magick = pcall(require, "magick")
    -- if has_magick then
    require("image").setup(opts)
    -- end
  end,
}
