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
        nls.builtins.formatting.fish_indent,
        nls.builtins.diagnostics.fish,
        nls.builtins.formatting.nixpkgs_fmt,
        nls.builtins.formatting.beautysh,
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
