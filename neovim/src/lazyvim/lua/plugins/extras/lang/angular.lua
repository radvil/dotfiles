local NG_ROOT_MARKERS = { "angular.json", "project.json" }

---@type table<string, boolean>
local workspace_cache = {}

---@param bufnr integer
---@return boolean
local function is_angular_workspace(bufnr)
  local buf_name = vim.api.nvim_buf_get_name(bufnr)
  local target = buf_name ~= "" and vim.fs.dirname(buf_name) or (vim.uv.cwd() or "")
  if target == "" then
    return false
  end
  -- check fast workspace/project markers first (no file reads needed)
  local marker_root = vim.fs.root(target, NG_ROOT_MARKERS)
  if marker_root then
    if workspace_cache[marker_root] ~= nil then
      return workspace_cache[marker_root]
    end
    workspace_cache[marker_root] = true
    return true
  end
  -- vim.notify("Cached: should only triggered once", "warn")
  -- fallback: find nearest package.json directory and cache by directory path
  local pkg_root = vim.fs.root(target, { "package.json" })
  if not pkg_root then
    return false
  end
  if workspace_cache[pkg_root] ~= nil then
    return workspace_cache[pkg_root]
  end
  -- NX + Angular detection fill fall here
  local is_ng = false
  local pkg_path = vim.fs.joinpath(pkg_root, "package.json")
  local ok, lines = pcall(vim.fn.readfile, pkg_path)
  if ok and type(lines) == "table" then
    local content = table.concat(lines, "\n")
    is_ng = content:find('"@angular/core"', 1, true) ~= nil
  end
  workspace_cache[pkg_root] = is_ng
  return is_ng
end

return {
  recommended = function()
    return LazyVim.extras.wants({
      root = {
        "angular.json",
        "nx.json", --support for nx workspace
      },
    })
  end,

  {
    "nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "angular", "scss" })
      end
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "*.html" },
        group = vim.api.nvim_create_augroup("HtmlAngularTreesitter", { clear = true }),
        callback = function(args)
          if is_angular_workspace(args.buf) then
            pcall(vim.treesitter.start, args.buf, "angular")
          end
        end,
      })
    end,
  },

  -- angularls depends on typescript
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- LSP Servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          keys = {
            {
              "<leader>cr",
              function()
                local bufnr = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr })
                ---@type nil | vim.lsp.Client
                local target_client = nil
                for _, client in ipairs(clients) do
                  if client.name == "angularls" then
                    target_client = client
                    break
                  elseif client.name == "tsc" or client.name == "vtsls" or client.name == "ts_ls" then
                    target_client = client
                  end
                end
                if target_client then
                  vim.lsp.buf.rename(nil, { name = target_client.name })
                else
                  vim.lsp.buf.rename()
                end
              end,
              desc = "Rename variable",
            },
          },
          root_dir = function(bufnr, on_dir)
            -- prefer the top-level nx config if it exists (monorepo support)
            local git = vim.fs.root(bufnr, ".git")
            local markers = NG_ROOT_MARKERS
            local root = git and vim.fs.root(git, markers) or vim.fs.root(bufnr, markers)
            if root then
              on_dir(root)
            end
          end,
        },
      }, -- EOL opts.servers
      setup = {
        angularls = function()
          -- Snacks.util.lsp.on({ name = "angularls" }, function(_, client)
          --   client.server_capabilities.renameProvider = false
          -- end)
        end,
      },
    },
  },

  -- Configure tsserver plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
        {
          name = "@angular/language-server",
          location = LazyVim.get_pkg_path("angular-language-server", "/node_modules/@angular/language-server"),
          enableForWorkspaceTypeScriptVersions = false,
        },
      })
    end,
  },

  -- formatting
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      if LazyVim.has_extra("lang.typescript.oxc") then
        opts.formatters_by_ft.htmlangular = { "oxfmt" }
      elseif LazyVim.has_extra("formatting.prettier") then
        opts.formatters_by_ft.htmlangular = { "prettier" }
      end
    end,
  },

  {
    "nvim-mini/mini.icons",
    optional = true,
    opts = {
      file = {
        ["angular.json"] = {
          glyph = "",
          hl = "MiniIconsRed",
        },
      },
      extension = {
        ["module.ts"] = {
          glyph = "",
          hl = "MiniIconsRed",
        },
        ["service.ts"] = {
          glyph = "",
          hl = "MiniIconsYellow",
        },
        ["component.ts"] = {
          glyph = "",
          hl = "MiniIconsAzure",
        },
        ["pipe.ts"] = {
          glyph = "",
          hl = "MiniIconsCyan",
        },
        ["routes.ts"] = {
          glyph = "",
          hl = "MiniIconsGreen",
        },
      },
    },
  },

  -- navigation
  ---@type LazyPlugin
  {
    "wkwk-hehe/Wkwk.NgNav",
    name = "Wkwk.NgNav",
    version = "*",
    -- dev = true,
    -- cmd = { "At", "Ac", "As", "Atc", "Ap", "Atv", "Acv", "Asv" },
    -- ft = { "typescript", "htmlangular", "json" },
    cond = function()
      return is_angular_workspace(0)
    end,
    opts = {
      workspace = {
        ignored_dirs = {
          "node_modules",
          ".angular",
          "dist",
          ".git",
          ".nx",
        },
      },
    },
    config = function(opts)
      local mod = require("wkwk.ng-nav")
      local api = mod.Api
      mod.setup(opts)
      -- stylua: ignore start
      local uc = vim.api.nvim_create_user_command
      uc("Atc", api.ViewTypeCheckBlock, { desc = "[Wkwk.NgNav] Display typecheck block under cursor" })
      uc("At", api.GoToComponentTemplate, { desc = "[Wkwk.NgNav] Go to template file" })
      uc("Ac", api.GoToComponentClass, { desc = "[Wkwk.NgNav] Go to component file" })
      uc("As", api.GoToComponentStylesheet, { desc = "[Wkwk.NgNav] Go to stylesheet file" })
      uc("Atv", function() api.GoToComponentTemplate({ split = "vsplit" }) end, { desc = "[Wkwk.NgNav] Open template file in vertical split" })
      uc("Acv", function() api.GoToComponentClass({ split = "vsplit" }) end, { desc = "[Wkwk.NgNav] Open component file in vertical split" })
      uc("Asv", function() api.GoToComponentStylesheet({ split = "vsplit" }) end, { desc = "[Wkwk.NgNav] Open stylesheet file in vertical split" })
      uc("Ap", function () api.OpenProjects({ split = "tab split" }) end, { desc = "[Wkwk.NgNav] Select projects" })
      -- stylua: ignore end
    end,
  },
}
