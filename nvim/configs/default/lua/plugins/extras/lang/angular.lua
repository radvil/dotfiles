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
local cmd = function(id, cmd, desc)
  vim.api.nvim_create_user_command(string.format("A%s", id), cmd, {
    desc = string.format("Angular » %s", desc),
  })
end

-- ---@param root_dir? string
-- local getNgCmd = function(root_dir)
--   local bun = os.getenv("HOME") .. "/.bun"
--   local bun_libs = string.format("%s/install/global/node_modules", bun)
--   return {
--     bun .. "/bin/ngserver",
--     "--stdio",
--     "--tsProbeLocations",
--     root_dir .. "," .. bun_libs,
--     "--ngProbeLocations",
--     root_dir .. "," .. bun_libs .. "/@angular/language-server/node_modules",
--   }
-- end

---@param root_dir string
local function getServerCmd(root_dir)
  ---@diagnostic disable-next-line: param-type-mismatch
  local node_root = vim.fs.dirname(vim.fs.find(root_dir, { upward = true })[1])
  local project_node_dir = node_root and node_root .. "/node_modules" or node_root
  local glob_server_node_dir =
    table.concat({ vim.fn.stdpath("data"), "/mason/packages/angular-language-server/node_modules" })
  return {
    "ngserver",
    "--stdio",
    "--tsProbeLocations",
    table.concat({ project_node_dir, glob_server_node_dir }, ","),
    "--ngProbeLocations",
    table.concat({ project_node_dir, glob_server_node_dir .. "/@angular/language-server/node_modules" }, ","),
  }
end

return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "angular", "scss" })
      end
    end,
  },

  {
    "nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          on_new_config = function(new_config, new_root_dir)
            new_config.cmd = getServerCmd(new_root_dir)
          end,
          root_dir = function(root_dir)
            local is_angular = require("lspconfig.util").root_pattern("angular.json", "nx.json")
            return is_angular(root_dir)
          end,
        },
      },
      setup = {
        angularls = function()
          LazyVim.lsp.on_attach(function(client)
            if client.name == "angularls" then
              client.server_capabilities.renameProvider = false
              client.server_capabilities.signatureHelpProvider = nil
              cmd("c", goToComponentFile, "Go to component file")
              cmd("t", goToTemplateFile, "Go to template file")
            end
          end)
        end,
      },
    },
  },
}
