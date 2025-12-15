let
  excludedDirectories = [ "" ];
  directoryContents = builtins.readDir ./.;
  directories = builtins.filter (
    name: directoryContents."${name}" == "directory" && !(builtins.elem name excludedDirectories)
  ) (builtins.attrNames directoryContents);
  imports = map (name: ./. + "/${name}") directories;
in
{
  imports = imports;
}
