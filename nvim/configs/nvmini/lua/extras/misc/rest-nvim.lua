---@type LazySpec[]
return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_install) == "table" then
        vim.list_extend(opts.ensure_install, {
          "http",
          "json",
        })
      end
    end,
  },

  ---@usage: https://github.com/rest-nvim/rest.nvim/blob/main/tests/basic_get.http
  {
    "rest-nvim/rest.nvim",
    commit = "91badd46c60df6bd9800c809056af2d80d33da4c",
    dependencies = "nvim-lua/plenary.nvim",
    ft = "http",
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
      env_file = ".env",
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
          end,
        },
      },
    },
    config = function(_, opts)
      require("rest-nvim").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        group = Lonard.create_augroup("http-result-preview"),
        desc = "Enable wrap on http result",
        pattern = { "httpResult" },
        callback = function()
          vim.schedule(function()
            vim.o.wrap = true
          end)
        end,
      })
    end,
  },
}
