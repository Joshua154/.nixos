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

      xorg.libX11
      xorg.libXext
      xorg.libXrandr
      xorg.libxcb
    ];
  };
}