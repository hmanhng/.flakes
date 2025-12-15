{
  disk ? "nvme0n1",
  ...
}:
{
  disko.devices = {
    disk = {
      ${disk} = {
        device = "/dev/${disk}";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              size = "512M";
              type = "EF00";
              label = "boot";
              content = {
                type = "filesystem";
                format = "vfat";
                # extraArgs = ["-F 32"];
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              end = "-500G"; # space for win and linux mint
              label = "luks";
              content = {
                type = "luks";
                name = "crypted";
                # disable settings.keyFile if you want to use interactive password entry
                passwordFile = "/tmp/secret.key"; # Interactive
                settings = {
                  allowDiscards = true;
                  crypttabExtraOpts = [ "tpm2-device=auto" ];
                  # keyFile = "/tmp/secret.key";
                };
                # additionalKeyFiles = ["/tmp/additionalSecret.key"];
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # Override existing partition
                  postCreateHook = ''
                    MNTPOINT=$(mktemp -d)
                    mount "/dev/mapper/crypted" "$MNTPOINT" -o subvol=/
                    trap 'umount $MNTPOINT; rm -rf $MNTPOINT' EXIT
                    btrfs subvolume snapshot -r $MNTPOINT/rootfs $MNTPOINT/rootfs-blank
                  '';
                  subvolumes = {
                    "rootfs" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd"
                        "lazytime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
