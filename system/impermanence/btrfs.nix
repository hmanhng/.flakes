{config, ...}: {
  services.btrfs.autoScrub.enable = true;
  boot.initrd = {
    supportedFilesystems = ["btrfs"];

    systemd.services.restore-root = {
      description = "Rollback btrfs rootfs";
      wantedBy = ["initrd.target"];
      requires = [
        "dev-disk-by\\x2dpartlabel-disk\\x2dnvme0n1\\x2dnixos.device"
        # for luks
        # "dev-pool-root.device"
      ];
      after = [
        "dev-disk-by\\x2dpartlabel-disk\\x2dnvme0n1\\x2dnixos.device"
        # for luks
        # "dev-pool-root.device"
        # "systemd-cryptsetup@${config.networking.hostName}.service"
      ];
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /mnt

        mount -o subvol=/ /dev/disk/by-partlabel/disk-nvme0n1-nixos /mnt

        btrfs subvolume list -o /mnt/rootfs |
        cut -f9 -d' ' |
        while read subvolume; do
          echo "deleting /$subvolume subvolume..."
          btrfs subvolume delete "/mnt/$subvolume"
        done &&
        echo "deleting /rootfs subvolume..." &&
        btrfs subvolume delete /mnt/rootfs

        echo "restoring blank /rootfs subvolume..."
        btrfs subvolume snapshot /mnt/rootfs-blank /mnt/rootfs

        # Once we're done rolling back to a blank snapshot,
        # we can unmount /mnt and continue on the boot process.
        umount /mnt
      '';
    };
  };
}
