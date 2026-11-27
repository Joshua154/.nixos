{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl

      # UI
      glib
      dbus
      fontconfig
      freetype
      nss
      nspr

      # Graphics / Wayland / X11
      libGL
      libgbm
      libxkbcommon

      libX11
      libXext
      libXrandr
      libxcb
    ];
  };
}