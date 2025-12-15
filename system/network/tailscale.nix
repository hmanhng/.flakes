{
  config,
  lib,
  ...
}:
{
  imports = [
    ./tailscale-autoconnect.nix
  ];

  sops.secrets.tailscale_auth = { };
  services = {
    tailscaleAutoconnect = {
      enable = true;
      authkeyFile = config.sops.secrets.tailscale_auth.path;
      loginServer = "https://login.tailscale.com";
      advertiseExitNode = lib.mkDefault false;
      exitNode = "amazone";
      exitNodeAllowLanAccess = true;
    };
  };
}
