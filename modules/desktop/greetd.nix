{pkgs, ...}:
# greetd display manager
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      };
    };
  };

  # # unlock GPG keyring on login
  # security.pam.services.greetd.enableGnomeKeyring = true;
}
