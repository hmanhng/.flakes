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
    config = function(_, opts)
      vim.g.autoformat = false
    end,
  },
  --[[ { "williamboman/mason-lspconfig.nvim", enabled = false }, -- Never use it, compile ? fuk shit ]]
  {
    "williamboman/mason.nvim",
    enabled = true,
    opts = function(_, opts)
      table.remove(opts.ensure_installed, 1)
    end,
  },
}
