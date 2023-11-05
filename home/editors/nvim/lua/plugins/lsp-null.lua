return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {},
        --[[ pyright = {}, ]]
        bashls = {},
        --[[ gopls = {}, ]]
        --[[ cssls = {}, ]]
      },
    },
  },
}
