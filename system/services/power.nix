{
  services = {
    logind.settings.Login.HandlePowerKey = "suspend";

    tuned.enable = true;

    # battery info
    upower.enable = true;
  };
}
