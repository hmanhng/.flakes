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
          "git *" = "allow";
          "git commit *" = "deny";
          "git push *" = "deny";
        };
      };
      plugin = [ "opencode-with-claude" ];
      provider = {
        anthropic = {
          options = {
            baseURL = "http://127.0.0.1:3456";
            apiKey = "dummy";
          };
        };
      };
    };
  };
}
