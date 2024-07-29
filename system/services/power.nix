{
  services = {
    logind.powerKey = "suspend";

    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };

        battery = {
          governor = "powersave";
          turbo = "auto";
        };
      };
    };

    # battery info
    upower.enable = true;
  };
}
