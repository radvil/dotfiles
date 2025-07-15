local snippets = os.getenv("DOTFILES") .. "/components/neovim/assets/snippets"

return {
  "LuaSnip",

  opts = {
    json_snippets = {
      snippets .. "/all",
      snippets .. "/angular",
    },
  },

  config = function(_, opts)
    if type(opts.json_snippets) == "table" then
      require("luasnip.loaders.from_vscode").lazy_load({ paths = opts.json_snippets })
    end
  end,
}
