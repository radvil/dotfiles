local create_note_with_title = function()
  vim.ui.input({
    prompt = "Note title: ",
    completion = "file_in_path", -- :h command-completion
    default = "",
  }, function(value)
    if not value then
      LazyVim.warn("Note creation canceled", {
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
  {
    "which-key.nvim",
    optional = true,
    opts = {
      spec = {
        ["<leader>N"] = { name = "[N]ote/obsidian" },
      },
    },
  },

  {
    "epwalsh/obsidian.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    lazy = true,
    keys = {
      {
        "<leader>Nc",
        create_note_with_title,
        desc = "Note[obsidian] » Create new note",
      },
      {
        "<leader>No",
        "<cmd>ObsidianOpen<cr>",
        desc = "Note[obsidian] » Open",
      },
      {
        "<leader>Nn",
        "<cmd>ObsidianToday<cr>",
        desc = "Note[obsidian] » Today/now note",
      },
      {
        "<leader>Ny",
        "<cmd>ObsidianYesterday<cr>",
        desc = "Note[obsidian] » Yesterday note",
      },
      {
        "<leader>Nb",
        ft = "markdown",
        "<cmd>ObsidianBacklinks<cr>",
        desc = "Obsidian » Show backlinks",
      },
      {
        "<leader>Nt",
        ft = "markdown",
        "<cmd>ObsidianTemplate<cr>",
        desc = "Obsidian » Insert a template",
      },
      {
        "gF",
        ft = "markdown",
        "<cmd>ObsidianLinkNew<cr>",
        desc = "Obsidian » Link to new note",
        mode = { "v", "x" },
      },
    },
    opts = {
      dir = os.getenv("NOTES_DIR"),
      mappings = {},
      finder = "telescope.nvim",
      completion = { nvim_cmp = true },
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
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
      LazyVim.safe_keymap_set("n", "gf", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<cr>"
        else
          return "gf"
        end
      end, { desc = "follow obsidian link" })
    end,
  },
}
