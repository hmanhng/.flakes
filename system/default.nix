let
  desktop = [
    ./core
    ./core/boot.nix

    ./hardware/graphics.nix
    ./hardware/fwupd.nix
    ./hardware/android.nix

    ./network/avahi.nix
    ./network/default.nix
    # ./network/tailscale.nix

    ./programs

    ./services
    ./services/location.nix
    ./services/gnome-services.nix
    ./services/greetd.nix
    ./services/pipewire.nix
  ];

  laptop =
    desktop
    ++ [
      ./hardware/bluetooth.nix
      ./hardware/brillo.nix

      ./services/power.nix
    ];
in {
  inherit desktop laptop;
}
