return {
  {
    "NvChad/nvterm",
    keys = {
      { "<leader>t", desc = "Terminal" },
      {
        "<leader>th",
        function()
          require("nvterm.terminal").toggle("horizontal")
        end,
        desc = "Terminal horizontal",
      },
      {
        "<leader>tv",
        function()
          require("nvterm.terminal").toggle("vertical")
        end,
        desc = "Terminal vertical",
      },
      {
        "<leader>tf",
        function()
          require("nvterm.terminal").toggle("float")
        end,
        desc = "Terminal float",
      },
    },
    opts = {},
    --[[ config = function() ]]
    --[[   require("nvterm").setup() ]]
    --[[ end, ]]
  },
}
