let
  desktop = [
    ./core
    ./core/boot.nix

    ./hardware/graphics.nix
    ./hardware/fwupd.nix

    ./network/avahi.nix
    ./network/default.nix
    # ./network/tailscale.nix

    ./programs
    ./programs/android.nix

    ./services
    ./services/fcitx5-lotus.nix
    ./services/location.nix
    ./services/gnome-services.nix
    ./services/greetd.nix
    ./services/pipewire.nix
  ];

  laptop = desktop ++ [
    ./hardware/bluetooth.nix
    # ./hardware/brillo.nix # use noctalia

    ./services/power.nix
  ];
in
{
  inherit desktop laptop;
}
