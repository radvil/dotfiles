---@type LazySpec[]
return {
  {
    "nvim-treesitter",
    opts = {
      -- ensure_installed = { "lua", "xml", "http", "json", "graphql" }
      ensure_installed = {
        "http",
        "json"
      }
    }
  },

  ---@usage: https://github.com/rest-nvim/rest.nvim/blob/main/tests/basic_get.http
  {
    "rest-nvim/rest.nvim",
    commit = "91badd46c60df6bd9800c809056af2d80d33da4c",
    dependencies = "nvim-lua/plenary.nvim",
    ft = 'http',
    opts = {
      result_split_horizontal = false,
      -- Keep the http file buffer above|left when split horizontal|vertical
      result_split_in_place = false,
      -- stay in current windows (.http file) or change to results window (default)
      stay_in_current_window_after_split = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Encode URL before making request
      encode_url = true,
      -- Jump to request line on run
      jump_to_request = true,
      env_file = '.env',
      -- for telescope select
      env_pattern = "\\.env$",
      env_edit_command = "tabedit",
      custom_dynamic_variables = {},
      yank_dry_run = true,
      search_back = true,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        -- show the generated curl command in case you want to launch
        -- the same request via the terminal (can be verbose)
        show_curl_command = true,
        show_http_info = true,
        show_headers = true,
        -- table of curl `--write-out` variables or false if disabled
        -- for more granular control see Statistics Spec
        show_statistics = false,
        -- executables or functions for formatting response body [optional]
        -- set them to false if you want to disable them
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
          end
        },
      },
    },
    config = function(_, opts)
      require("rest-nvim").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        group = require("neoverse.utils").create_augroup("http-result-preview"),
        desc = "Enable wrap on http result",
        pattern = { "httpResult" },
        callback = function()
          vim.schedule(function()
            vim.o.wrap = true
          end)
        end
      })
    end
  },

  ---@usage: https://github.com/rest-nvim/rest.nvim/blob/main/tests/basic_get.http
  -- {
  --   "rest-nvim/rest.nvim",
  --   ft = 'http',
  --   dependencies = {
  --     {
  --       "vhyrro/luarocks.nvim",
  --       opts = {
  --         rocks = {
  --           "lua-curl",
  --           "nvim-nio",
  --           "mimetypes",
  --           "xml2lua"
  --         },
  --       }
  --     }
  --   },
  --   opts = {
  --     client = "curl",
  --     env_file = ".env",
  --     env_pattern = "\\.env$",
  --     env_edit_command = "tabedit",
  --     encode_url = true,
  --     skip_ssl_verification = false,
  --     custom_dynamic_variables = {},
  --     logs = {
  --       level = "info",
  --       save = true,
  --     },
  --     highlight = {
  --       enable = true,
  --       timeout = 750,
  --     },
  --     result = {
  --       split = {
  --         in_place = false,
  --         horizontal = false,
  --         stay_in_current_window_after_split = true,
  --       },
  --       behavior = {
  --         decode_url = true,
  --         show_info = {
  --           url = true,
  --           headers = true,
  --           http_info = true,
  --           curl_command = true,
  --         },
  --         formatters = {
  --           json = "jq",
  --           html = function(body)
  --             if vim.fn.executable("tidy") == 0 then
  --               return body, { found = false, name = "tidy" }
  --             end
  --             local fmt_body = vim.fn.system({
  --               "tidy",
  --               "-i",
  --               "-q",
  --               "--tidy-mark", "no",
  --               "--show-body-only", "auto",
  --               "--show-errors", "0",
  --               "--show-warnings", "0",
  --               "-",
  --             }, body):gsub("\n$", "")
  --
  --             return fmt_body, { found = true, name = "tidy" }
  --           end,
  --         },
  --       },
  --     },
  --     -- keybinds = {
  --     --   { "<localleader>rr", "<cmd>Rest run<cr>",      "Run request under the cursor", },
  --     --   { "<localleader>rl", "<cmd>Rest run last<cr>", "Re-run latest request", },
  --     -- }
  --   },
  --   config = function(_, opts)
  --     require("rest-nvim").setup(opts)
  --     vim.api.nvim_create_autocmd("FileType", {
  --       group = require("neoverse.utils").create_augroup("http-result-preview"),
  --       desc = "Enable wrap on http result",
  --       pattern = { "httpResult" },
  --       callback = function()
  --         vim.schedule(function()
  --           vim.o.wrap = true
  --         end)
  --       end
  --     })
  --   end
  -- }
}
