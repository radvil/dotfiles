---@type LazySpec
return {
  "echasnovski/mini.indentscope",
  event = "LazyFile",

  keys = function()
    return {
      {
        "<leader>uI",
        function()
          vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
          if vim.g.miniindentscope_disable then
            LazyVim.warn("Disabled", { title = "Indentscope Marker" })
          else
            LazyVim.info("Enabled", { title = "Indentscope Marker" })
          end
        end,
        desc = "toggle [I]ndent scope",
      },
    }
  end,

  init = function()
    -- disable by default
    vim.g.miniindentscope_disable = true
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "DiffviewFiles",
        "fugitiveblame",
        "NeogitStatus",
        "Dashboard",
        "dashboard",
        "MundoDiff",
        "gitcommit",
        "lazyterm",
        "NvimTree",
        "neo-tree",
        "fugitive",
        "Outline",
        "Trouble",
        "lspinfo",
        "prompt",
        "dirbuf",
        "notify",
        "alpha",
        "Mundo",
        "mason",
        "lazy",
        "edgy",
        "dbui",
        "help",
        "qf",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,

  opts = function()
    return {
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 200,
        animation = require("mini.indentscope").gen_animation.none(),
      },
      mappings = {
        goto_top = "[i",
        goto_bottom = "]i",
        object_scope = "ii",
        object_scope_with_border = "ai",
      },
    }
  end,
}
