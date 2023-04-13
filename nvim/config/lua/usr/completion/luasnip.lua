---@type LazySpec
local M = {}
M[1] = "L3MON4D3/LuaSnip"
M.event = "InsertEnter"
M.opts = {
  delete_check_events = "TextChanged",
  history = true,
}
M.init = function()
  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
          require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end
M.config = function()
  local vscode_loader = require("luasnip.loaders.from_vscode")
  vscode_loader.lazy_load()
  vscode_loader.lazy_load({
    paths = {
      rvim.path.config .. "/assets/snippets/all/",
      rvim.path.config .. "/assets/snippets/angular/",
    },
  })
end
return M
