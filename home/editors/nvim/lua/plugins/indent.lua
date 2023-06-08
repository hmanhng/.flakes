return {
  {
    "lukas-reineke/indent-blankline.nvim",
    --[[ enabled = false, ]]
    opts = {
      --[[ vim.opt.listchars:append("eol:↴"), ]]
      char = "¦",
    },
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = "¦",
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify", "fzf" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      }),
    },
  },
}
