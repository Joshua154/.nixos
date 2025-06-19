{ config, pkgs, ... }:

let
  Mojava-window-right-dark = pkgs.stdenv.mkDerivation {
    name = "Mojava-window-right-dark";
    src = ./themeFiles;
    installPhase = ''
      mkdir -p $out
      cp -r * $out/
    '';
  };
in {
  boot.loader.grub.theme = "${Mojava-window-right-dark}";
}