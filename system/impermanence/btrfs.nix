{ config, ... }:
{
  services.btrfs.autoScrub.enable = true;
  boot.initrd = {
    supportedFilesystems = [ "btrfs" ];

    # https://guekka.github.io/nixos-server-1/
    systemd.services.restore-root = {
      description = "Rollback btrfs rootfs";
      wantedBy = [ "initrd.target" ];
      requires = [
        # "dev-disk-by\\x2dpartlabel-nixos.device"
        # for luks
        "dev-mapper-crypted.device"
      ];
      after = [
        # "dev-disk-by\\x2dpartlabel-nixos.device"
        # for luks
        "dev-mapper-crypted.device"
        "systemd-cryptsetup@${config.networking.hostName}.service"
      ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /mnt
        # We first mount the btrfs rootfs to /mnt
        # so we can manipulate btrfs subvolumes.
        #mount -o subvol=/ /dev/nvme0n1p2 /mnt
        mount -o subvol=/ /dev/mapper/crypted /mnt

        # While we're tempted to just delete /rootfs and create
        # a new snapshot from /rootfs-blank, /rootfs is already
        # populated at this point with a number of subvolumes,
        # which makes `btrfs subvolume delete` fail.
        # So, we remove them first.
        #
        # /rootfs contains subvolumes:
        # - /rootfs/var/lib/portables
        # - /rootfs/var/lib/machines
        #
        # I suspect these are related to systemd-nspawn, but
        # since I don't use it I'm not 100% sure.
        # Anyhow, deleting these subvolumes hasn't resulted
        # in any issues so far, except for fairly
        # benign-looking errors from systemd-tmpfiles.
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
