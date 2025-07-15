---@alias MaterialVariant "darker" | "lighter" | "deep ocean" | "oceanic" | "palenight"

local next = nil
local bg_default = {
  ---@type MaterialVariant
  dark = "palenight",
  ---@type MaterialVariant
  light = "lighter",
}

return {
  "marko-cerovac/material.nvim",
  name = "material",
  lazy = not string.match(vim.g.neo_colorscheme, "meterial"),
  opts = {
    lualine_style = "default",
    contrast = {
      terminal = false,
      sidebars = false,
      floating_windows = false,
      cursor_line = false,
      lsp_virtual_text = false,
      non_current_windows = false,
      filetypes = {},
    },
    styles = {
      comments = { --[[ italic = true ]]
      },
      strings = { --[[ bold = true ]]
      },
      keywords = { --[[ underline = true ]]
      },
      functions = { --[[ bold = true, undercurl = true ]]
      },
      variables = {},
      operators = {},
      types = {},
    },

    plugins = {
      -- Available plugins:
      -- "coc",
      -- "colorful-winsep",
      -- "dap",
      -- "dashboard",
      -- "eyeliner",
      -- "fidget",
      -- "flash",
      -- "gitsigns",
      -- "harpoon",
      -- "hop",
      -- "illuminate",
      -- "indent-blankline",
      -- "lspsaga",
      -- "mini",
      -- "neogit",
      -- "neotest",
      -- "neo-tree",
      -- "neorg",
      -- "noice",
      -- "nvim-cmp",
      -- "nvim-navic",
      -- "nvim-tree",
      -- "nvim-web-devicons",
      -- "rainbow-delimiters",
      -- "sneak",
      -- "telescope",
      -- "trouble",
      -- "which-key",
      -- "nvim-notify",
    },
    disable = {
      colored_cursor = false, -- Disable the colored cursor
      borders = false, -- Disable borders between vertically split windows
      background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
      term_colors = false, -- Prevent the theme from setting terminal colors
      eob_lines = false, -- Hide the end-of-buffer lines
    },
    high_visibility = {
      lighter = false, -- Enable higher contrast text for lighter style
      darker = false, -- Enable higher contrast text for darker style
    },
  },
  config = function(_, opts)
    if opts.disable and type(opts.disable) == "table" then
      opts.disable.background = vim.g.neo_transparent
    end
    vim.g.material_style = next or bg_default[vim.o.background]
    require("material").setup(opts)
  end,
  init = function()
    local augroup = vim.api.nvim_create_augroup("neo_autocmds_colorscheme_material", {})
    vim.api.nvim_create_autocmd("OptionSet", {
      group = augroup,
      pattern = "background",
      desc = "On Background Changed",
      callback = function()
        if vim.g.colors_name and string.match(vim.g.colors_name, "material") then
          if vim.v.option_old == vim.v.option_new then
            return
          else
            next = vim.v.option_new == "dark" and bg_default.light or bg_default.dark
            vim.schedule(function()
              vim.cmd.Lazy("reload material")
            end)
          end
        end
      end,
    })
  end,
}
