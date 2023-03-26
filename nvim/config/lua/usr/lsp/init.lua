return {
  require("usr.lsp.mason"),
  require("usr.lsp.lspconfig"),
  require("usr.lsp.null-ls"),
  require("usr.lsp.lang.typescript"),
  require("usr.lsp.lang.angularls").treesitter,
}
