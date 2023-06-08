return {
  "ggandor/leap.nvim",
  opts = {
    highlight_unlabeled_phase_one_targets = true,
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }),
    vim.api.nvim_set_hl(0, "LeapMatch", { fg = "#eebebe", bold = true, nocombine = true }),
    vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#a6d189", bold = true, nocombine = true }),
    vim.api.nvim_set_hl(0, "LeapLabelSecondary", { fg = "#78ddff", bold = true, nocombine = true }),
    -- Try it without this setting first, you might find you don't even miss it.
  },
}
