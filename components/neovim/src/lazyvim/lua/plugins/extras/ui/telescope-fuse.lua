local M = {}

M.create_fused_layout = function(picker)
  local Layout = require("nui.layout")
  local Popup = require("nui.popup")
  local TSLayout = require("telescope.pickers.layout")
  local function make_popup(options)
    local popup = Popup(options)
    function popup.border:change_title(title)
      popup.border.set_text(popup.border, "top", title)
    end
    return TSLayout.Window(popup)
  end
  local border = {
    results = {
      top_left = "┌",
      top = "─",
      top_right = "┬",
      right = "│",
      bottom_right = "",
      bottom = "",
      bottom_left = "",
      left = "│",
    },
    results_patch = {
      minimal = {
        top_left = "┌",
        top_right = "┐",
      },
      horizontal = {
        top_left = "┌",
        top_right = "┬",
      },
      vertical = {
        top_left = "├",
        top_right = "┤",
      },
    },
    prompt = {
      top_left = "├",
      top = "─",
      top_right = "┤",
      right = "│",
      bottom_right = "┘",
      bottom = "─",
      bottom_left = "└",
      left = "│",
    },
    prompt_patch = {
      minimal = {
        bottom_right = "┘",
      },
      horizontal = {
        bottom_right = "┴",
      },
      vertical = {
        bottom_right = "┘",
      },
    },
    preview = {
      top_left = "┌",
      top = "─",
      top_right = "┐",
      right = "│",
      bottom_right = "┘",
      bottom = "─",
      bottom_left = "└",
      left = "│",
    },
    preview_patch = {
      minimal = {},
      horizontal = {
        bottom = "─",
        bottom_left = "",
        bottom_right = "┘",
        left = "",
        top_left = "",
      },
      vertical = {
        bottom = "",
        bottom_left = "",
        bottom_right = "",
        left = "│",
        top_left = "┌",
      },
    },
  }

  local results = make_popup({
    focusable = false,
    border = {
      style = border.results,
      text = {
        top = picker.results_title,
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal",
    },
  })

  local prompt = make_popup({
    enter = true,
    border = {
      style = border.prompt,
      text = {
        top = picker.prompt_title,
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal",
    },
  })

  local preview = make_popup({
    focusable = false,
    border = {
      style = border.preview,
      text = {
        top = picker.preview_title,
        top_align = "center",
      },
    },
  })

  local box_by_kind = {
    vertical = Layout.Box({
      Layout.Box(preview, { grow = 1 }),
      Layout.Box(results, { grow = 1 }),
      Layout.Box(prompt, { size = 3 }),
    }, { dir = "col" }),
    horizontal = Layout.Box({
      Layout.Box({
        Layout.Box(results, { grow = 1 }),
        Layout.Box(prompt, { size = 3 }),
      }, { dir = "col", size = "50%" }),
      Layout.Box(preview, { size = "50%" }),
    }, { dir = "row" }),
    minimal = Layout.Box({
      Layout.Box(results, { grow = 1 }),
      Layout.Box(prompt, { size = 3 }),
    }, { dir = "col" }),
  }

  local function get_box()
    local strategy = picker.layout_strategy
    if strategy == "vertical" or strategy == "horizontal" then
      return box_by_kind[strategy], strategy
    end
    local height, width = vim.o.lines, vim.o.columns
    local box_kind = "horizontal"
    if width < 100 then
      box_kind = "vertical"
      if height < 40 then
        box_kind = "minimal"
      end
    end
    return box_by_kind[box_kind], box_kind
  end

  local function prepare_layout_parts(layout, box_type)
    layout.results = results
    results.border:set_style(border.results_patch[box_type])
    layout.prompt = prompt
    prompt.border:set_style(border.prompt_patch[box_type])
    if box_type == "minimal" then
      layout.preview = nil
    else
      layout.preview = preview
      preview.border:set_style(border.preview_patch[box_type])
    end
  end
  local function get_layout_size(box_kind)
    return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
  end
  local box, box_kind = get_box()
  local layout = Layout({
    relative = "editor",
    position = "50%",
    size = get_layout_size(box_kind),
  }, box)
  layout.picker = picker
  prepare_layout_parts(layout, box_kind)
  local layout_update = layout.update
  function layout:update()
    local _box, _box_kind = get_box()
    prepare_layout_parts(layout, _box_kind)
    layout_update(self, { size = get_layout_size(_box_kind) }, _box)
  end
  return TSLayout(layout)
end

<<<<<<<< HEAD:nvim/configs/default/lua/plugins/extras/ui/telescope-fuse.lua
return {
  "telescope.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = function(_, opts)
    if type(opts.defaults) == "table" then
      opts.defaults.layout_strategy = "flex"
      opts.defaults.create_layout = create_fused_layout
      opts.defaults.layout_config = {
        horizontal = {
          size = {
            width = "80%",
            height = "80%",
          },
        },
        vertical = {
          size = {
            width = "80%",
            height = "90%",
          },
        },
      }
    end
  end,
}
========
return M
>>>>>>>> variant/fedora:nvim/configs/default/lua/fuse.lua
