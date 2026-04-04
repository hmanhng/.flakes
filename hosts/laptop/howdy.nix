{
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  irEmitterPackage =
    self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linux-enable-ir-emitter-beta;

  # Generate IR emitter rule for a PAM service
  mkIrEmitterRule = name: {
    inherit name;
    value = {
      rules.auth.ir-emitter = {
        order = 100; # Run early, before other auth modules
        control = "optional";
        modulePath = "${pkgs.pam}/lib/security/pam_exec.so";
        args = [
          "${lib.getExe irEmitterPackage}"
          "run"
          "--config"
          "/etc/linux-enable-ir-emitter.toml"
        ];
      };
    };
  };

  # List of PAM services to add IR emitter to (based on /etc/pam.d/)
  # Only includes services that require user authentication
  pamServicesToEnable = [
    "login" # Console login
    "sudo" # sudo command
    # "doas" # doas (sudo alternative)
    # "su" # switch user
    # "polkit-1" # PolicyKit authentication
    # "greetd" # greetd login manager
    # "hyprlock" # Hyprland screen locker
    # "swaylock" # Sway screen locker
    # "vlock" # Virtual console locker
    # "systemd-run0" # systemd run0 (modern sudo replacement)
  ];
in
{
  # Add IR emitter to system packages so it's available
  environment.systemPackages = [ irEmitterPackage ];

  # Create IR emitter config file
  environment.etc."linux-enable-ir-emitter.toml".text = ''
    [["/dev/video2".savelist]]
    unit = 7
    selector = 6
    control = [1, 3, 2, 0, 0, 0, 0, 0, 0]
  '';

  services.howdy = {
    enable = true;
    control = "sufficient";
    settings = {
      core = {
        no_confirmation = true;
        abort_if_ssh = true;
      };
      video.dark_threshold = 90;
    };
  };

  # Configure PAM to run IR emitter before Howdy and disable Howdy for SSH
  security.pam.services = {
    # Disable Howdy for SSH
    sshd.howdy.enable = false;
    polkit-1.howdy.enable = false;
  }
  // builtins.listToAttrs (map mkIrEmitterRule pamServicesToEnable);
}
