{
  user,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    terraform
  ];
}
