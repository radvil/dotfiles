---@type LazySpec
local M = {}

M[1] = "glepnir/dashboard-nvim"

M.enabled = false

M.event = "VimEnter"

M.opts = {
  theme = "doom",
  hide = {
    statusline = true,
    tabline = false,
    winbar = false,
  },
  config = {
    header = rnv.opt.welcome_header,
    footer = {
      "                       ",
      "                       ",
      "🔥 WELCOME BACK FUCKER!",
    },
    center = {
      {
        key = "p",
        icon = "  ",
        desc = "Manage Plugins                           ",
        desc_hi = "DashboardCenter",
        action = "Lazy",
      },
      {
        key = "o",
        icon = "📁 ",
        desc = "Open recent files                        ",
        desc_hi = "DashboardCenter",
        action = "Telescope oldfiles",
      },
      {
        key = "f",
        icon = "🔎 ",
        desc = "Find files                               ",
        desc_hi = "DashboardCenter",
        action = "Telescope find_files",
      },
      {
        key = "t",
        icon = "📌 ",
        desc = "List all tasks                           ",
        desc_hi = "DashboardCenter",
        action = "TodoTelescope",
      },
      {
        key = ".",
        icon = "🔧 ",
        desc = "Open dotfiles                            ",
        desc_hi = "DashboardCenter",
        action = "Dotfiles",
      },
      {
        key = "s",
        icon = "👻 ",
        desc = "Restore session                          ",
        desc_hi = "DashboardCenter",
        action = 'lua require("usr.misc.persistence").api.restore_session()',
      },
    },
  },
}

M.init = function()
  ---@desc close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "DashboardReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end
end

return M
