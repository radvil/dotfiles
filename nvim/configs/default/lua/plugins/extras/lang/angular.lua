local goToTemplateFile = function()
  local params = vim.lsp.util.make_position_params(0)
  vim.lsp.buf_request(0, "angular/getTemplateLocationForComponent", params, function(_, result)
    if result then
      vim.lsp.util.jump_to_location(result, "utf-8")
    end
  end)
end

local goToComponentFile = function()
  local params = vim.lsp.util.make_position_params(0)
  vim.lsp.buf_request(0, "angular/getComponentsWithTemplateFile", params, function(_, result)
    if result then
      if #result == 1 then
        vim.lsp.util.jump_to_location(result[1], "utf-8")
      else
        vim.fn.setqflist({}, " ", {
          title = "Angular Language Server",
          items = vim.lsp.util.locations_to_items(result, "utf-8"),
        })
        vim.cmd.copen()
      end
    end
  end)
end

---@param id string
---@param cmd string | function
---@param desc string
local create_command = function(id, cmd, desc)
  vim.api.nvim_create_user_command(string.format("A%s", id), cmd, {
    desc = string.format("Angular » %s", desc),
  })
end

local is_angular = function(root_dir)
  return require("lspconfig.util").root_pattern("angular.json", "project.json")(root_dir)
end

return {
  recommended = function()
    return LazyVim.extras.wants({
      root = { "angular.json" },
    })
  end,

  {
    "nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "angular", "html", "scss" })
      end
    end,
  },

  -- depends on the typescript extra
  { import = "plugins.extras.lang.typescript" },

  -- LSP Servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- html = {
        --   filetypes = { "html", "templ", "svg", "angular.html" },
        -- },
        tailwindcss = {
          filetypes_include = { "angular.html" },
        },
        angularls = {
          filetypes = { "typescript", "html", "angular.html", "typescriptreact", "tsx" },
          root_dir = is_angular,
        },
      },
      setup = {
        angularls = function()
          if is_angular(vim.uv.cwd()) then
            create_command("c", goToComponentFile, "Go to component file")
            create_command("t", goToTemplateFile, "Go to template file")
            vim.filetype.add({
              pattern = {
                -- [".*%.component%.html"] = "angular.html",
                -- [".*%.component%.svg"] = "angular.html",
                [".*%.html"] = "angular.html",
                [".*%.svg"] = "angular.html",
              },
            })
            vim.api.nvim_create_autocmd("FileType", {
              pattern = "angular.html",
              callback = function()
                vim.treesitter.language.register("angular", "angular.html")
              end,
            })
          end
          LazyVim.lsp.on_attach(function(client, bufnr)
            if client.name == "vtsls" then
              client.server_capabilities.renameProvider = false
            end
            if client.name == "html" and vim.bo[bufnr].filetype == "angular.html" then
              client.server_capabilities.renameProvider = false
            end
          end)
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
          language = { "angular" },
        },
      })
    end,
  },
}
