{
  self,
  inputs,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];

    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
      inputs.nur.overlay
    ];
  };
}
