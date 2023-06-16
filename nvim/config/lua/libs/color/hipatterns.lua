---@type LazySpec[]
return {
  ---TOGGLE
  "echasnovski/mini.hipatterns",
  config = function()
    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      delay = {
        text_change = 200,
        scroll = 50,
      },
      highlighters = {
        -- fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'TodoBgFIX' },
        -- hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'TodoBgHack' },
        -- todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'TodoBgTODO' },
        -- note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'TodoBgNOTE' },
        toggle    = { pattern = '%f[%w]()TOGGLE()%f[%W]', group = 'TodoBgWARN' },
        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
  end
}
