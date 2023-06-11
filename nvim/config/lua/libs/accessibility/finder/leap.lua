---@desc: motion jumper
---@type LazySpec
local M = {}

M[1] = "ggandor/leap.nvim"

M.enabled = false

-- M.event = "VeryLazy"

-- M.dependencies = {
--   "ggandor/flit.nvim",
--   opts = {
--     labeled_modes = "nv",
--     keys = {
--       f = "f",
--       F = "F",
--       t = "t",
--       T = "T",
--     },
--   },
-- }

M.opts = {
  highlight_unlabeled_phase_one_targets = false,
  safe_labels = {},
  labels = {},
  case_sensitive = false,
  special_keys = {
    next_target = { "<Enter>", "<Tab>" },
    prev_target = { "<S-Enter>", "," },
    next_group = "<Space>",
    prev_group = "<Tab>",
  },
}

local leap_mode = { "n", "x", "v", "o" }

M.keys = {
  {
    "m",
    "<Plug>(leap-forward-to)",
    mode = leap_mode,
  },
  {
    "<C-m>",
    "<Plug>(leap-backward-to)",
    mode = leap_mode,
  },
}

return M
