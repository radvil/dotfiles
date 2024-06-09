---@type string
local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

---@param path string
local function have(path)
  return vim.uv.fs_stat(xdg_config .. "/" .. path) ~= nil
end

return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
      },
    },
  },
  {
    "mason.nvim",
    optional = true,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "shfmt",
        "shellcheck",
      })
    end,
  },
  {
    "nvim-treesitter",
    opts = function(_, opts)
      local function add(lang)
        if type(opts.ensure_install) == "table" then
          table.insert(opts.ensure_install, lang)
        end
      end

      vim.filetype.add({
        extension = { rasi = "rasi" },
        pattern = {
          [".*/waybar/config"] = "jsonc",
          [".*/mako/config"] = "dosini",
          [".*/kitty/*.conf"] = "bash",
          [".*/hypr/.*%.conf"] = "hyprlang",
        },
      })

      add("git_config")

      if have("hypr") then
        add("hyprlang")
      end

      if have("fish") then
        add("fish")
      end

      if have("rofi") or have("wofi") then
        add("rasi")
      end
    end,
  },
}
