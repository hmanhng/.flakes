return {
  -- add gruvbox
  {
    "EdenEast/nightfox.nvim",
    --[[ lazy = true, ]]
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
      highlight_overrides = {
        all = function(colors)
          return {
            IndentBlanklineChar = { fg = colors.surface2, nocombine = true },
            CursorLineNr = { fg = "#44b2fc", style = { "bold" } },
            CursorLine = { bg = colors.none },
            LineNr = { fg = colors.surface2 },
          }
        end,
      },
      integrations = {
        telescope = false,
        --[[ mini = false, ]]
        noice = false,
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
      --[[ colorscheme = "nightfox", ]]
    },
  },
}
