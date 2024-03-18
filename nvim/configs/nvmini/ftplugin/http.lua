local Utils = require("neoverse.utils")

-- @commit 91badd46c60df6bd9800c809056af2d80d33da4c
Utils.map("n", "<cr>", "<Plug>RestNvim", {
  desc = "rest.nvim » run the request under the cursor",
  buffer = true,
})

Utils.map("n", "<c-r>", "<Plug>RestNvimLast", {
  desc = "rest.nvim » run last request",
  buffer = true,
})

-- Utils.map("n", "<cr>", "<cmd>Rest run<cr>", {
--   desc = "rest.nvim » run the request under the cursor",
--   buffer = true,
-- })
--
-- Utils.map("n", "<c-r>", "<cmd>Rest run last<cr>", {
--   desc = "rest.nvim » run last request",
--   buffer = true,
-- })
