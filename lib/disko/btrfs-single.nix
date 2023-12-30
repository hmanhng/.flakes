{disk ? "nvme0n1", ...}: {
  disko.devices = {
    disk = {
      ${disk} = {
        device = "/dev/${disk}";
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "esp";
              start = "1MiB";
              end = "512MiB";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                extraArgs = ["-F 32"];
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            }
            {
              name = "nixos";
              start = "512MiB";
              end = "-150GB";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                mountOptions = ["defaults"];
                postCreateHook = ''
                  MNTPOINT=$(mktemp -d)
                  mount "/dev/disk/by-partlabel/nixos" "$MNTPOINT" -o subvol=/
                  trap 'umount $MNTPOINT; rm -rf $MNTPOINT' EXIT
                  btrfs subvolume snapshot -r $MNTPOINT/rootfs $MNTPOINT/rootfs-blank
                '';
                subvolumes = {
                  "rootfs" = {
                    mountpoint = "/";
                    mountOptions = ["compress=lzo" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=lzo" "noatime"];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=lzo" "lazytime"];
                  };
                };
              };
            }
          ];
        };
      };
    };
  };
}
