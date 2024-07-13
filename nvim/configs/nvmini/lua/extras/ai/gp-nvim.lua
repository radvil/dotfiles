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
    keys = {
      {
        "<c-g>u",
        "<cmd>GpChatToggle<cr>",
        desc = "GpChat » Toggle Chat",
      },
      {
        "<c-g>f",
        "<cmd>GpChatFinder<cr>",
        desc = "GpChat » Finder",
      },
      {
        "<c-g>p",
        ":GpChatPaste<cr>",
        desc = "GpChat » Paste to the latest chat",
        mode = "v",
      },
    },
    opts = {
      openai_api_key = {
        "gpg",
        "--decrypt",
        os.getenv("DOTFILES") .. "/secrets/open-ai-key.gpg",
      },
    },
    init = function()
      vim.api.nvim_create_user_command("Gpt", function ()
        require("gp").new_chat({}, nil, "You are the best programmer, your name is Neo", true)
      end, { desc = "gp.nvim » start new toggleable chat" })
      vim.api.nvim_create_user_command("Ngpt", function ()
        local prompt =  "You are the best Angular & Typescript programmer, your name is Anjink. You will assist me in an Web Development. You can give any explanation to the code, but don't be to long."
        require("gp").new_chat({}, nil, prompt, true)
      end, { desc = "gp.nvim » start Angular AI Assistant" })
    end,
  },
}
