# networking configuration
{ pkgs, ... }:
{
  networking = {
    # use 1.1.1.1 with DNS over TLS
    nameservers = [ "1.1.1.1#one.one.one.one" ];

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
    };
  };

  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };

    # DNS resolver
    resolved = {
      enable = true;
      settings.Resolve.DNSOverTLS = true;
    };
  };

  systemd.services.NetworkManager-wait-online.serviceConfig.ExecStart = [
    ""
    "${pkgs.networkmanager}/bin/nm-online -q"
  ];
}
