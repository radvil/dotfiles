return {
  "mbbill/undotree",
  lazy = false,
  keys = {
    {
      "<Leader>mU",
      vim.cmd.UndotreeToggle,
      desc = "[U]ndotree",
    },
  },
  opts = {
    WindowLayout = 4,
    CursorLine = true,
    HelpLine = true,
    DiffAutoOpen = true,
    SetFocusWhenToggle = true,
    RelativeTimestamp = true,
    HighlightChangedText = true,
    HighlightChangedWithSign = true,
    TreeNodeShape = "*",
    TreeVertShape = "|",
    TreeReturnShape = [[\]],
    UndoDir = vim.fn.stdpath("state") .. "/undo"
  },
  config = function(_, opts)
    for key, value in pairs(opts) do
      if type(value) == "boolean" then
        value = value == true and 1 or 0
      end
      vim.g["undotree_" .. key] = value
    end
  end,
}
