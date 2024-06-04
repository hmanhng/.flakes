{inputs, ...}: {
  imports = [
    inputs.auto-cpufreq.nixosModules.default
  ];

  programs.auto-cpufreq = {
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

  # services.thermald.enable = true; # only or intel cpu
}
