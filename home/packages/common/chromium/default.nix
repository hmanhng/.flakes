{
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--force-device-scale-factor=1.1"
      "--ignore-gpu-blocklist"
      "--enable-features=VaapiVideoDecoder"
    ];
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock origin
      { id = "fdjamakpfbbddfjaooikfcpapjohcfmg"; } # Dashlane
      { id = "edibdbjcniadpccecjdfdjjppcpchdlm"; } # I still don't care about cookies
      { id = "hmlcjjclebjnfohgmgikjfnbmfkigocc"; } # J2TEAM Security
      { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # Enhancer for YouTube™
    ];
  };
}
