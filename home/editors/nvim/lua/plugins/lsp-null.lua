return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = { mason = false },
        --[[ pyright = {}, ]]
        bashls = {},
        --[[ gopls = {}, ]]
        --[[ cssls = {}, ]]
      },
    },
  },
  --[[ { "williamboman/mason-lspconfig.nvim", enabled = false }, -- Never use it, compile ? fuk shit ]]
  {
    "williamboman/mason.nvim",
    enabled = true,
    opts = {
      ensure_installed = {},
    },
  },
}
