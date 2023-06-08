return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    --[[ ensure_installed = "all", ]]
    ensure_installed = { "nix", "lua", "bash" },
    auto_install = true,
  },
}
