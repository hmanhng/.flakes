{default, ...}: {
  imports = [
    ./code
    ./nvim
    ./emacs
    ./jetbrains
  ];
  home = {
    sessionVariables = {
      EDITOR = "${default.editor}";
    };
  };
}
