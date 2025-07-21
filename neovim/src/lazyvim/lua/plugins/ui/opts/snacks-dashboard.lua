---@class snacks.dashboard.Config
---@field sections snacks.dashboard.Section
---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
return {
  preset = {
    header = [[
_______________                              _______________
`-._           \           |\__/|           /           _.-'
    \           \          |    |          /           /    
     \           `-_______/      \_______-'           /     
     /_______                                  _______\     
             `----._                    _.----'             
                    `--.            .--'                    
                        `-.      .-'                        
                           \    /                           
                            \  /                            
                             \/                             ]],
    ---@type snacks.dashboard.Item[]
    keys = {
      {
        action = ":lua require('persistence').load()",
        desc = " Resume session",
        icon = "🕗",
        key = "s",
      },
      {
        action = ":lua Snacks.dashboard.pick('oldfiles')",
        desc = " Recent files",
        icon = "📁",
        key = "r",
      },
      {
        action = ":lua Snacks.dashboard.pick('files')",
        desc = " Find files",
        icon = "🔭",
        key = "f",
      },
      {
        action = ":lua Snacks.dashboard.pick('live_grep')",
        desc = " Grep words",
        icon = "🔎",
        key = "w",
      },
      -- {
      --   action = ":NeoNotes",
      --   desc = " Find notes",
      --   icon = "📌",
      --   key = "n",
      -- },
      -- {
      --   action = ":NeoDotfiles",
      --   desc = " Config files",
      --   icon = "🔧",
      --   key = "d",
      -- },
      {
        action = ":Lazy",
        desc = " Manage plugins",
        icon = "📎",
        key = "p",
      },
      {
        action = ":LazyExtra",
        desc = " Manage extra",
        icon = " ",
        key = "x",
      },
      {
        action = ":qa",
        desc = " Quit session",
        icon = "⭕",
        key = "q",
      },
    },
  },
  sections = {
    { section = "header" },
    {
      pane = 2,
      section = "terminal",
      cmd = "colorscript -e square",
      height = 4,
      padding = 2,
    },
    {
      section = "keys",
      padding = 1,
      gap = 1,
    },
    {
      pane = 2,
      icon = " ",
      title = "Recent Files",
      section = "recent_files",
      indent = 2,
      padding = 2,
    },
    {
      pane = 2,
      icon = " ",
      title = "Projects",
      section = "projects",
      indent = 2,
      padding = 2,
    },
    {
      pane = 2,
      icon = " ",
      title = "Git Status",
      section = "terminal",
      enabled = function()
        return Snacks.git.get_root() ~= nil
      end,
      cmd = "hub status --short --branch --renames",
      height = 5,
      padding = 1,
      ttl = 5 * 60,
      indent = 3,
    },
    { section = "startup" },
  },
}
