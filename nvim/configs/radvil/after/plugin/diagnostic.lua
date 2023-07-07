vim.diagnostic.config {
  signs = true,
  underline = true,
  virtual_text = {
    severity = nil,
    source = "if_many",
    format = nil,
  },

  float = {
    show_header = true,
    -- border = "rounded",
    -- source = "always",
    format = function(d)
      if not d.code and not d.user_data then
        return d.message
      end

      local t = vim.deepcopy(d)
      local code = d.code
      if not code then
        if not d.user_data.lsp then
          return d.message
        end

        code = d.user_data.lsp.code
      end
      if code then
        t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
      end
      return t.message
    end,
  },

  -- general purpose
  severity_sort = true,
  update_in_insert = false,
}
