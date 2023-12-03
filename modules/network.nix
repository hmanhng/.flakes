{
  lib,
  config,
  ...
}:
# networking configuration
{
  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
    };
  };

  sops.secrets.tailscale_auth = {};
  services = {
    tailscaleAutoconnect = {
      enable = true;
      authkeyFile = config.sops.secrets.tailscale_auth.path;
      loginServer = "https://login.tailscale.com";
      advertiseExitNode = lib.mkDefault false;
      exitNode = "amazone";
      exitNodeAllowLanAccess = true;
    };
    # network discovery, mDNS

    # avahi = {
    #   enable = true;
    #   nssmdns = true;
    #   publish = {
    #     enable = true;
    #     domain = true;
    #     userServices = true;
    #   };
    # };

    openssh = {
      enable = true;
      settings.UseDns = true;
    };

    # DNS resolver
    resolved.enable = true;
  };

  # Don't wait for network startup
  # systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
