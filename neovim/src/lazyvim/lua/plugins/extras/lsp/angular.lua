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
                  elseif client.name == "ts_ls" or client.name == "tsc" or client.name == "vtsls" then
                    target_client = client
                  end
                end
                if target_client then
                  vim.lsp.buf.rename(nil, { name = target_client.name })
                else
                  vim.lsp.buf.rename()
                end
              end,
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
      if LazyVim.has_extra("formatting.prettier") then
        opts.formatters_by_ft = opts.formatters_by_ft or {}
        opts.formatters_by_ft.htmlangular = { "prettier" }
      end
    end,
  },
}
