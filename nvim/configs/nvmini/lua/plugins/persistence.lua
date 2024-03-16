return {
  "folke/persistence.nvim",
  optional = true,
  opts = function(_, opts)
    if type(opts) == "table" then
      opts.pre_save = function()
        require("neoverse.utils").info("saving session...", {
          title = "persistence",
          animate = false,
        })
      end
    end
  end,
}
