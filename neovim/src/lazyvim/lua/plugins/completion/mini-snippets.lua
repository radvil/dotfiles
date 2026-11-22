local gen_loader = require("mini.snippets").gen_loader
local snippets = os.getenv("DOTFILES") .. "/neovim/assets/snippets"

return {
  "mini.snippets",
  opts = {
    -- <c-c> by default, see :h MiniSnippets-session
    mappings = { stop = "<a-q>" },
    snippets = {
      -- gen_loader.from_file(snippets .. "/all/package.json"),
      gen_loader.from_file(snippets .. "/all/css.json"),
      gen_loader.from_file(snippets .. "/all/html.json"),
      gen_loader.from_file(snippets .. "/all/javascript.json"),
      gen_loader.from_file(snippets .. "/all/lua.json"),
      gen_loader.from_file(snippets .. "/all/markdown.json"),
      gen_loader.from_file(snippets .. "/all/rust.json"),
      gen_loader.from_file(snippets .. "/all/typescript.json"),
      gen_loader.from_file(snippets .. "/angular/html.json"),
      gen_loader.from_file(snippets .. "/angular/jsonc.json"),
      -- gen_loader.from_file(snippets .. "/angular/package.json"),
      gen_loader.from_file(snippets .. "/angular/dockerfile.json"),
      gen_loader.from_file(snippets .. "/angular/javascript.json"),
      gen_loader.from_file(snippets .. "/angular/typescript.json"),
    },
  },
}
