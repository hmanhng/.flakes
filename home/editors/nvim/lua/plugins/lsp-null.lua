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
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = {
        nls.builtins.formatting.nixpkgs_fmt,
      }
    end,
  },
  { "williamboman/mason-lspconfig.nvim", enabled = false }, -- Never use it, compile ? fuk shit
  {
    "williamboman/mason.nvim",
    enabled = true,
    opts = {
      ensure_installed = {},
    },
  },
}
