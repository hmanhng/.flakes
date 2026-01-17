{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.android-tools
  ];

  users.users.hmanhng.extraGroups = [ "adbusers" ];
}
