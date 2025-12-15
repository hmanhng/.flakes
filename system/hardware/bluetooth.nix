{ pkgs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez5-experimental;
    settings = {
      General = {
        # Battery info for Bluetooth devices
        Experimental = true;
        ControllerMode = "bredr";
        FastConnectable = true;
      };
    };
  };

  # services.blueman.enable = true;
  # home-manager.users.hmanhng.services.blueman-applet.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/114222
  # systemd.user.services.telephony_client.enable = false;
}
