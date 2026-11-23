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
        callback = function()
          vim.treesitter.start(nil, "angular")
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
              desc = "Format Angular Code",
            },
          },
          root_dir = function(bufnr, on_dir)
            -- prefer the top-level nx config if it exists (monorepo support)
            local git = vim.fs.root(bufnr, ".git")
            local markers = { "nx.json", "angular.json", "project.json" }
            local root = git and vim.fs.root(git, markers) or vim.fs.root(bufnr, markers)
            if root then
              on_dir(root)
            end
          end,
        },
      },
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

  -- navigation
  ---@type LazyPlugin
  {
    "Wkwk-Hehe/NgNav",
    name = "Wkwk.NgNav",
    dev = true,
    -- cmd = { "At", "Ac", "As", "Atc", "Ap", "Atv", "Acv", "Asv" },
    -- ft = { "typescript", "htmlangular", "json" },
    cond = function()
      local root = vim.fs.root(0, { "angular.json", "nx.json" })
      if not root then
        return false
      end
      -- Fallback for Nx / Angular workspaces using project.json
      -- local fallback = vim.fn.filereadable(vim.fs.joinpath(root, "project.json")) == 1
      -- vim.print(fallback)
      return true
    end,
    opts = {
      ignored_dirs = { "node_modules", ".git", "dist", ".nx", ".angular" },
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
