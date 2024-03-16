return {
  "rcarriga/nvim-notify",
  optional = true,
  opts = function(_, opts)
    opts.render = "wrapped-compact"
    opts.stages = "fade"
    if type(opts.banned_messages) == "table" then
      vim.list_extend(opts.banned_messages, { "No information available" })
    end
  end,
}
