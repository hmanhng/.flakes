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
              name = "root";
              start = "512MiB";
              end = "70%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = ["--allow-discards"];
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            }
          ];
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
              mountOptions = [
                "defaults"
                "lazytime"
              ];
              postCreateHook = ''
                MNTPOINT=$(mktemp -d)
                mount "/dev/mapper/pool-root" "$MNTPOINT" -o subvol=/
                trap 'umount $MNTPOINT; rm -rf $MNTPOINT' EXIT
                btrfs subvolume snapshot -r $MNTPOINT/rootfs $MNTPOINT/rootfs-blank
              '';
              subvolumes = {
                "rootfs" = {
                  mountpoint = "/";
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["compress=zstd" "noatime"];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = ["compress=zstd"];
                };
              };
            };
          };
        };
      };
    };
  };
}
