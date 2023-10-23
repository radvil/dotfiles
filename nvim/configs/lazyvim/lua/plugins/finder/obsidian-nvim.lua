---@param lhs string
---@param rhs string | function
local Kmap = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, {
    desc = string.format("Obsidian » %s", desc),
    noremap = false,
    expr = true,
  })
end

local create_note_with_title = function()
  vim.ui.input({
    prompt = "Note title: ",
    completion = "file_in_path", -- :h command-completion
    default = "",
  }, function(value)
    if not value then
      vim.notify("Note creation canceled", vim.log.levels.WARN, {
        title = "Obsidian",
        icon = "󱙒 ",
      })
    else
      vim.cmd("ObsidianNew " .. value)
      -- no need extra notification here since obsidian.nvim has already handled this
    end
  end)
end

return {
  "epwalsh/obsidian.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    {
      "<leader>nc",
      create_note_with_title,
      desc = "Obsidian » Create new note",
    },
    {
      "<leader>no",
      ":ObsidianOpen<cr>",
      desc = "Obsidian » Open",
    },
    {
      "<leader>nb",
      ":ObsidianBacklinks<cr>",
      desc = "Obsidian » Show note's backlinks",
    },
    {
      "<leader>nn",
      ":ObsidianToday<cr>",
      desc = "Obsidian » Today/now note",
    },
    {
      "<leader>ny",
      ":ObsidianYesterday<cr>",
      desc = "Obsidian » Yesterday note",
    },
    {
      "<leader>nt",
      ":ObsidianTemplate<cr>",
      desc = "Obsidian » Insert a template",
    },
    {
      "gF",
      "<cmd>ObsidianLinkNew<cr>",
      desc = "Obsidian » Link to new note",
      mode = { "v", "x" },
    },
  },
  config = function()
    local obsidian = require("obsidian")
    local Prefer = require("preferences")
    local options = {
      mappings = {},
      finder = "telescope.nvim",
      completion = {
        nvim_cmp = true,
      },
      daily_notes = {
        folder = "+daily",
        date_format = "%Y-%m-%d",
      },
      follow_url_func = function(url)
        vim.fn.jobstart({ "xdg-open", url })
      end,
      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
    }

    if type(Prefer.note_dir) == "function" then
      options.dir = Prefer.note_dir()
    elseif type(Prefer.note_dir) == "string" then
      options.dir = Prefer.note_dir
    else
      options.dir = vim.fn.expand("~") .. "/obsidian-nvim-notes"
    end

    obsidian.setup(options)

    Kmap("gf", function()
      if obsidian.util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<cr>"
      else
        return "gf"
      end
    end, "Follow link")
  end,

  init = function()
    if require("utils").call("which-key.nvim") then
      require("which-key").register({
        mode = "n",
        ["<leader>n"] = { name = "Note(Obsidian)" },
      })
    end
  end,
}
