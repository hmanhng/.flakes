{pkgs, ...}: {
  programs.adb.enable = true;
  users.users.hmanhng.extraGroups = ["adbusers"];
  environment.systemPackages = with pkgs; [
    jadx # smali to java
    apktool # apktool
  ];
}
