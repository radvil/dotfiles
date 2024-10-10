return {
  desc = "GPT AI prompt for Neovim",

  {
    "which-key.nvim",
    optional = true,
    opts = {
      spec = {
        ["<c-g>"] = { name = "gp.nvim" },
      },
    },
  },

  {
    "radvil/gp.nvim",
    ---TODO: keymaps descriptions
    keys = {
      {
        "<c-g>u",
        "<Cmd>GpChatToggle<Cr>",
        desc = "GpChat » Toggle Chat",
      },
      {
        "<c-g>f",
        "<Cmd>GpChatFinder<Cr>",
        desc = "GpChat » Finder",
      },
      {
        "<c-g>p",
        "<Cmd>GpChatPaste<cr>",
        desc = "GpChat » Paste to the latest chat",
        mode = "v",
      },
    },
    opts = {
      model = "gpt-40",
      openai_api_key = {
        "echo",
        -- "gpg",
        -- "--decrypt",
        -- os.getenv("DOTFILES") .. "/secrets/open-ai-key.gpg",
      },
    },
    init = function()
      vim.api.nvim_create_user_command("Gpt", function()
        require("gp").new_chat({}, nil, "You are the best programmer, your name is Neo", true)
      end, { desc = "gp.nvim » start new toggleable chat" })
      vim.api.nvim_create_user_command("Ngpt", function()
        local prompt =
          "You are the best Angular & Typescript programmer, your name is Anjink. You will assist me in an Web Development. You can give any explanation to the code, but don't be to long."
        require("gp").new_chat({}, nil, prompt, true)
      end, { desc = "gp.nvim » start Angular AI Assistant" })
    end,
  },
}
