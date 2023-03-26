---@type LazySpec
local M = {}
M[1] = "echasnovski/mini.bufremove"
local function remove(force, bufnr)
  force = force == nil and false
  bufnr = bufnr == nil and 0
  require("mini.bufremove").delete(bufnr or 0, force or false)
end
M.init = function()
  vim.api.nvim_create_user_command("BD", function()
    remove()
  end, { desc = "Remove buffer [safe]" })
  vim.api.nvim_create_user_command("BAD", function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) then
        remove(false, bufnr)
      end
    end
  end, { desc = "Remove all buffers [safe]" })
  vim.api.nvim_create_user_command("BF", function()
    remove(true)
  end, { desc = "Remove buffer [force]" })
  vim.api.nvim_create_user_command("BAF", function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) then
        remove(true, bufnr)
      end
    end
  end, { desc = "Remove all buffers [force]" })
end
M.keys = {
  {
    "<Leader>bd",
    "<Cmd>BD<Cr>",
    desc = "CURRENT » Safe Delete",
  },
  {
    "<Leader>bf",
    "<Cmd>BF<Cr>",
    desc = "CURRENT » Force Delete",
  },
  {
    "<Leader>bD",
    "<Cmd>BAD<Cr>",
    desc = "ALL » Safe Delete",
  },
  {
    "<Leader>bF",
    "<Cmd>BAF<Cr>",
    desc = "ALL » Force Delete",
  },
}
return M
