---@diagnostic disable: missing-fields, assign-type-mismatch
---@class NeoFlashFtExcludes
local ftMap = {
  popups = {
    "TelescopeResults",
    "TelescopePrompt",
    "DressingInput",
    "flash_prompt",
    "cmp_menu",
    "WhichKey",
    "incline",
    "prompt",
    "notify",
    "noice",
  },
  excludes = {
    "DiffviewFiles",
    "dashboard",
    "NvimTree",
    "neo-tree",
    "Outline",
    "prompt",
    "alpha",
    "help",
    "dbui",
    "dirbuf",
    "gitcommit",
    "Trouble",
    "help",
    "qf",
  },
  sidebars = {
    "NvimTree",
    "neo-tree",
    "Outline",
  },
}

local telescope_pick = function(prompt_bufnr)
  require("flash").jump({
    pattern = "^",
    label = { after = { 0, 0 } },
    search = {
      mode = "search",
      exclude = {
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
        end,
      },
    },
    action = function(match)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      picker:set_selection(match.pos[1] - 1)
    end,
  })
end

return {
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      defaults = {
        mappings = {
          ["n"] = { ["<a-m>"] = telescope_pick },
          ["i"] = { ["<a-m>"] = telescope_pick },
        },
      },
    },
  },

  {
    "folke/flash.nvim",
    keys = function()
      return {
        {
          "<a-m>",
          mode = { "n", "i" },
          function()
            require("flash").jump({
              search = {
                exclude = ftMap.popups,
                autojump = false,
                forward = true,
                wrap = true,
              },
            })
          end,
          desc = "ju[m]p anywhere",
        },
        {
          "<a-m>",
          mode = { "x", "o" },
          function()
            require("flash").jump({
              search = {
                multi_window = false,
                forward = true,
                wrap = true,
              },
            })
          end,
          desc = "ju[m]p anywhere",
        },
        {
          "<a-s>",
          mode = { "n", "v", "x", "o" },
          function()
            require("flash").treesitter({
              label = {
                rainbow = {
                  enabled = false,
                  shades = 3,
                },
              },
            })
          end,
          desc = "[s]elect node",
        },
        {
          "go",
          mode = "n",
          function()
            require("flash").jump({
              search = {
                exclude = ftMap.popups,
                multi_window = true,
                autojump = false,
                forward = true,
              },
              ---@param state Flash.State
              action = function(target, state)
                state:hide()
                vim.api.nvim_set_current_win(target.win)
                vim.api.nvim_win_set_cursor(target.win, target.pos)
                if vim.tbl_contains(ftMap.sidebars, vim.bo.filetype) then
                  vim.api.nvim_input("<cr>")
                else
                  vim.api.nvim_input("gd")
                end
              end,
            })
          end,
          desc = "jump and [o]pen",
        },
        {
          "gO",
          mode = "n",
          function()
            require("flash").jump({
              search = {
                exclude = ftMap.popups,
                multi_window = true,
                autojump = false,
                forward = true,
              },
              ---@param target Flash.Match
              ---@param state Flash.State
              action = function(target, state)
                state:hide()
                local target_buf = vim.api.nvim_win_get_buf(target.win)
                if vim.list_contains(ftMap.sidebars, vim.bo[target_buf].filetype) then
                  vim.api.nvim_set_current_win(target.win)
                  vim.api.nvim_win_set_cursor(target.win, target.pos)
                  vim.api.nvim_input("<cr>")
                  return
                end
                local clients = vim.lsp.get_clients({
                  bufnr = target_buf,
                  method = "textDocument/definition",
                })
                if #clients == 0 then
                  vim.notify("No LSP client with definition support attached", vim.log.levels.WARN)
                  return
                end
                local client = clients[1]
                local params = {
                  textDocument = vim.lsp.util.make_text_document_params(target_buf),
                  position = {
                    line = target.pos[1] - 1,
                    character = target.pos[2],
                  },
                }
                client:request("textDocument/definition", params, function(err, result)
                  if err then
                    vim.notify("LSP definition error: " .. err.message, vim.log.levels.ERROR)
                    return
                  end
                  if not result or vim.tbl_isempty(result) then
                    vim.notify("No definition found", vim.log.levels.INFO)
                    return
                  end
                  local loc = vim.islist(result) and result[1] or result
                  local uri = loc.targetUri or loc.uri
                  local range = loc.targetSelectionRange or loc.targetRange or loc.range
                  local def_buf = vim.uri_to_bufnr(uri)
                  vim.fn.bufload(def_buf)
                  -- Snapshot buffer state so we can restore or unlock cleanly
                  local prev_modifiable = vim.bo[def_buf].modifiable
                  local prev_readonly = vim.bo[def_buf].readonly
                  local promoted_to_main = false
                  -- Lock buffer while inspecting inside the float
                  vim.bo[def_buf].modifiable = false
                  vim.bo[def_buf].readonly = true
                  local row = range.start.line + 1
                  local col = range.start.character
                  local default_width = 0.75
                  local default_height = 0.65
                  local maximized = false

                  local function open_from_float(self, open_cmd)
                    local cur = vim.api.nvim_win_get_cursor(self.win)
                    promoted_to_main = true
                    self:close()
                    if vim.api.nvim_buf_is_valid(def_buf) then
                      vim.bo[def_buf].modifiable = true
                      vim.bo[def_buf].readonly = false
                      if open_cmd then
                        vim.cmd(open_cmd)
                      end
                      vim.api.nvim_set_current_buf(def_buf)
                      vim.api.nvim_win_set_cursor(0, cur)
                    end
                  end

                  local win = Snacks.win({
                    buf = def_buf,
                    width = default_width,
                    height = default_height,
                    border = "rounded",
                    title = " " .. vim.fn.fnamemodify(vim.uri_to_fname(uri), ":~:.") .. ":" .. row .. " ",
                    title_pos = "center",
                    wo = {
                      number = true,
                      cursorline = true,
                      relativenumber = false,
                    },
                    on_close = function()
                      -- If closed via q / <Esc> without promoting, restore original flags
                      if not promoted_to_main and vim.api.nvim_buf_is_valid(def_buf) then
                        vim.bo[def_buf].modifiable = prev_modifiable
                        vim.bo[def_buf].readonly = prev_readonly
                      end
                    end,
                    keys = {
                      q = "close",
                      ["<esc>"] = "close",
                      ["<a-m>"] = {
                        function(self)
                          maximized = not maximized
                          if maximized then
                            self.opts.width = 0.98
                            self.opts.height = 0.94
                          else
                            self.opts.width = default_width
                            self.opts.height = default_height
                          end
                          self:update()
                          vim.api.nvim_win_call(self.win, function()
                            vim.cmd("normal! zz")
                          end)
                        end,
                        desc = "Toggle maximize",
                      },
                      ["<cr>"] = {
                        function(self)
                          open_from_float(self)
                        end,
                        desc = "Open in main window (writable)",
                      },
                      ["<c-t>"] = {
                        function(self)
                          open_from_float(self, "tabnew")
                        end,
                        desc = "Open in new tab (writable)",
                      },
                      ["<c-x>"] = {
                        function(self)
                          open_from_float(self, "split")
                        end,
                        desc = "Open in horizontal split (writable)",
                      },
                      ["<c-v>"] = {
                        function(self)
                          open_from_float(self, "vsplit")
                        end,
                        desc = "Open in vertical split (writable)",
                      },
                    },
                  })
                  vim.api.nvim_win_call(win.win, function()
                    vim.api.nvim_win_set_cursor(win.win, { row, col })
                    vim.cmd("normal! zz")
                  end)
                end, target_buf)
              end,
            })
          end,
          desc = "Jump and [o]pen definition in float",
        },
        {
          "gz",
          mode = "n",
          function()
            require("flash").jump({
              search = {
                exclude = ftMap.excludes,
                multi_window = true,
                autojump = false,
                forward = true,
              },
              ---@param state Flash.State
              action = function(target, state)
                state:hide()
                vim.api.nvim_set_current_win(target.win)
                vim.api.nvim_win_set_cursor(target.win, target.pos)
                vim.api.nvim_input("za")
                vim.schedule(function()
                  state:restore()
                end)
              end,
            })
          end,
          desc = "[z]ump + toggle fold",
        },
      }
    end,
    opts = {
      -- labels = "asdfghjklqwertyuiopzxcvbnm",
      -- NOTE: exclude j and k for better escape support
      labels = "asdfghlqwertyuiopzxcvbnm",
      search = {
        mode = "exact",
        forward = true,
        multi_window = true,
        incremental = false,
      },
      jump = {
        jumplist = true,
        pos = "start", ---@type "start" | "end" | "range"
        history = false,
        register = false,
        nohlsearch = true,
        autojump = false,
        filetype_exclude = ftMap.excludes,
      },
      label = {
        current = true,
        after = false,
        before = true,
        reuse = "lowercase",
      },
      highlight = {
        backdrop = true,
        matches = true,
        groups = {
          match = "FlashMatch",
          current = "FlashCurrent",
          backdrop = "FlashBackdrop",
          label = "FlashLabel",
        },
      },
      modes = {
        search = { enabled = false },
        char = { enabled = false },
        treesitter = {
          labels = "abcdefghijklmnopqrstuvwxyz",
          jump = { pos = "range" },
          backdrop = false,
          matches = false,
          label = {
            before = true,
            after = true,
            style = "inline",
          },
          highlight = {
            backdrop = false,
            matches = false,
          },
        },
      },
    }, -- [EOL opts]
    config = function(_, options)
      require("flash").setup(options)

      ---jump to definition with flash
      ---@param jump_type "vsplit" | "split" | "tab" | nil
      local jump_to_definition = function(jump_type)
        return function()
          require("flash").jump({
            search = {
              exclude = ftMap.popups,
              multi_window = true,
              autojump = false,
              forward = true,
            },
            ---@param state Flash.State
            action = function(target, state)
              state:hide()
              vim.api.nvim_set_current_win(target.win)
              vim.api.nvim_win_set_cursor(target.win, target.pos)
              Snacks.picker.lsp_definitions({ confirm = jump_type })
            end,
          })
        end
      end

      vim.api.nvim_create_user_command("JD", function(opts)
        local mode = opts.fargs[1] -- nil if called as just `:JD`, or "split" if `:JD split`
        if mode == nil then
          jump_to_definition()()
        elseif mode == "sp" then
          jump_to_definition("split")()
        elseif mode == "vs" then
          jump_to_definition("vsplit")()
        elseif mode == "tab" then
          jump_to_definition("tab")()
        else
          vim.notify("Invalid argument: " .. mode, vim.log.levels.ERROR)
        end
      end, {
        nargs = "?",
        desc = "Jump to definition (supports split, vsplit, tab)",
        complete = function(arg_lead)
          local subcommands = { "sp", "vs", "tab" }
          return vim.tbl_filter(function(item)
            return vim.startswith(item, arg_lead)
          end, subcommands)
        end,
      })
    end,
  },
}
