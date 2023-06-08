return {
  "folke/noice.nvim",
  opts = {
    cmdline = {
      enabled = true, -- enables the Noice cmdline UI
      view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    },
    views = {
      cmdline_popup = {
        position = {
          row = "50%",
          col = "50%",
        },
        border = {
          style = "single",
        },
      },
      mini = {
        win_options = {
          winblend = 0,
        },
      },
    },
  },
}
