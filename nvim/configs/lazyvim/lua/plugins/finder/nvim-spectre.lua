return {
  "nvim-pack/nvim-spectre",
  config = true,
  keys = function()
    return {
      {
        "<Leader>fr",
        function()
          require("spectre").open()
        end,
        desc = "Find and replace word",
      },
    }
  end,
}
