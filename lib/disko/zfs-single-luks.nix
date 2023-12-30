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
              name = "ESP";
              start = "1MiB";
              end = "512Mib";
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
              name = "luks";
              start = "512MiB";
              end = "-150GB"; # for dual boot
              content = {
                type = "luks";
                name = "nixos";
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_write_workqueue"
                  "--perf-no_read_workqueue"
                ];
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "zfs";
                  pool = "rpool";
                };
              };
            }
          ];
        };
      };
    };
    zpool = {
      rpool = {
        type = "zpool";

        rootFsOptions = {
          compression = "lz4";
          "com.sun:auto-snapshot" = "false";
          canmount = "off";
          xattr = "sa";
          atime = "off";
        };
        options = {
          ashift = "12";
          autotrim = "on";
        };
        datasets = {
          zroot = {
            type = "zfs_fs";
            mountpoint = "/";
            postCreateHook = "zfs snapshot rpool/zroot@blank";
            options = {
              mountpoint = "legacy";
            };
          };
          znix = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options = {
              mountpoint = "legacy";
            };
          };
          zhome = {
            type = "zfs_fs";
            mountpoint = "/home";
            postCreateHook = "zfs snapshot rpool/zhome@blank";
            options = {
              "com.sun:auto-snapshot" = "true";
              mountpoint = "legacy";
            };
          };
        };
      };
    };
  };
}
