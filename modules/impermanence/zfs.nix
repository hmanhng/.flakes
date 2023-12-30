{config, ...}: {
  networking = {
    hostId = "a2e4eded";
  };
  boot = {
    initrd = {
      verbose = true;
      supportedFilesystems = ["zfs"];
      postDeviceCommands = ''
        zfs rollback -r rpool/zroot@blank
      '';
    };
  };
  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };
}
