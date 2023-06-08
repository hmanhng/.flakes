{
  programs.git = {
    enable = true;
    userName = "Hmanhng";
    userEmail = "hmanhng@icloud.com";
    extraConfig = {
      url = {
        "git@github.com:hmanhng/" = {
          insteadOf = "https://github.com/hmanhng/";
        };
      };
    };
  };
  programs.lazygit.enable = true;
}
