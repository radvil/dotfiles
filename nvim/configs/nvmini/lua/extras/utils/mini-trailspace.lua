local neo_trim = function()
  local tspace = require("mini.trailspace")
  tspace.trim()
  tspace.trim_last_lines()
end

return {
  "echasnovski/mini.trailspace",
  opts = {},
  keys = {
    {
      "<leader>mt",
      neo_trim,
      desc = "[t]rim whitespaces",
    },
  },
  init = function()
    vim.api.nvim_create_user_command("NeoTrim", neo_trim, {
      desc = "Trim whitespaces",
    })
  end,
}
