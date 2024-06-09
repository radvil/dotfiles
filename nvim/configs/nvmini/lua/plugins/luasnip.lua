return {
  "L3MON4D3/LuaSnip",
  optional = true,
  ---@type NeoSnippetOpts
  opts = {
    json_snippets = {
      os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
      os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
    },
  },
}
