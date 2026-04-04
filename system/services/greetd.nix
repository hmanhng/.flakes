{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  # greetd display manager
  services.greetd =
    let
      session = {
        command = "${
          inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable
        }/bin/niri-session";
        user = "hmanhng";
      };
    in
    {
      enable = true;

      # do not restart on session exit (useful on autologin)
      restart = false;

      settings = {
        terminal.vt = 1;
        default_session = session;
        initial_session = session;
      };
    };

  # unlock GPG keyring on login
  # disabled as it doesn't work with autologin
  # security.pam.services.greetd.enableGnomeKeyring = true;
}
