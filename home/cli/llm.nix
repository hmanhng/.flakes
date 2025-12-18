{ pkgs, inputs, ... }:
{
  home.packages = with inputs.llm-agents.packages.${pkgs.system}; [
    qwen-code
  ];
}
