{
  fetchurl,
  lib,
  stdenv,
}@args:
let
  buildFirefoxXpiAddon = lib.makeOverridable (
    {
      stdenv ? args.stdenv,
      fetchurl ? args.fetchurl,
      pname,
      version,
      addonId,
      url,
      sha256,
      ...
    }:
    stdenv.mkDerivation {
      name = "${pname}-${version}";

      src = fetchurl { inherit url sha256; };

      preferLocalBuild = true;
      allowSubstitutes = true;

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
    }
  );
in
{
  default-zoom = buildFirefoxXpiAddon {
    pname = "default-zoom";
    version = "1.1.3";
    addonId = "default-zoom@jamielinux.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/3567861/default_zoom-1.1.3.xpi";
    sha256 = "sha256-bbAC380jFU8Q0ewXfM5O1YcbJXrlnF279WqV2dkgGHY=";
  };
  aria2 = buildFirefoxXpiAddon {
    pname = "aria2-integration";
    version = "4.3.0";
    addonId = "baptistecdr@users.noreply.github.com";
    url = "https://addons.mozilla.org/firefox/downloads/file/4099805/aria2_extension-4.3.0.xpi";
    sha256 = "sha256-MXDHbdSYzaEpQcUz/YXQqKQ5t6q4h83O+84KHN2nAqI=";
  };
}
