return {
  "LuaSnip",

  opts = {
    json_snippets = {
      os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
      os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
    },
  },

  config = function(_, opts)
    if type(opts.json_snippets) == "table" then
      require("luasnip.loaders.from_vscode").lazy_load({ paths = opts.json_snippets })
    end
  end,
}
