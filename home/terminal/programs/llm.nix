{ pkgs, inputs, ... }:
{
  programs.opencode = {
    enable = true;
    package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
    settings = {
      permission = {
        edit = "ask";
        bash = {
          "*" = "ask";
          "ls" = "allow";
        };
      };
    };
  };
}
