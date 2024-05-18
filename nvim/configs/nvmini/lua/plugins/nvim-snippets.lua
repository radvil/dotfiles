return {
  "nvim-snippets",
  optional = true,
  opts = {
    friendly_snippets = true,
    search_paths = {
      os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
      os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
    },
  },
}
