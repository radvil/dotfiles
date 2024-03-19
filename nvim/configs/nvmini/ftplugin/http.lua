local Utils = require("neoverse.utils")

Utils.map("n", "<cr>", "<Plug>RestNvim", {
  desc = "rest.nvim » run the request under the cursor",
  buffer = true,
})

Utils.map("n", "<c-r>", "<Plug>RestNvimLast", {
  desc = "rest.nvim » run last request",
  buffer = true,
})
