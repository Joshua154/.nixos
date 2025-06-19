{ config, pkgs, ... }:

let
  minegrub = pkgs.stdenv.mkDerivation {
    name = "minegrub";
    src = ./themeFiles;
    installPhase = ''
      mkdir -p $out
      cp -r * $out/
    '';
  };
in {
  boot.loader.grub.theme = "${minegrub}";
}