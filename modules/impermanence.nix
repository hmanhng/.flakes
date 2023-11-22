{
  inputs,
  user,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.impermanence];
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
      "/etc/NetworkManager/system-connections"
      # "/etc/v2raya"
      "/var/log"
      "/var/lib"
      # "/etc/secureboot"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.${user} = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "Desktop"
        ".cache"
        ".config"
        ".local"
        ".flakes"
        # "Kvm"
        # { directory = ".gnupg"; mode = "0700"; }
        {
          directory = ".ssh";
          mode = "0700";
        }
        ".mozilla"
        ".vscode"
        # ".logseq"
        ".java"
        ".fly"
      ];
      files = [
      ];
    };
  };
}
