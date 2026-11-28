return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
    },
    keymap = {
      ["<a-space>"] = { "hide", "fallback" },
    },
    sources = {
      providers = {
        cmdline = {
          min_keyword_length = function(ctx)
            if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
              return 3
            end
            return 0
          end,
        },
      },
    },
  },
}
