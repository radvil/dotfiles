return {
  "nvim-snippets",
  optional = true,
  opts = {
    friendly_snippets = true,
    search_paths = {
      os.getenv("HOME") .. "/.dotfiles/nvim/assets/snippets/all",
      os.getenv("HOME") .. "/.dotfiles/nvim/assets/snippets/angular",
    },
  },
}
