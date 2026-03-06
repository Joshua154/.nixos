# Shared configuration modules that are common across all hosts
{ config, pkgs, lib, ... }:

{
  imports = [
    ./android.nix
    ./boot.nix
    ./cloudflared.nix
    ./fonts.nix
    ./hardware.nix
    ./localsend.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    ./virtualisation.nix
  ];

  # Graphics configuration - default without specific GPU
  services.xserver.enable = lib.mkDefault true;

  # XDG Portal configuration
  xdg = {
    portal.enable = true;
    mime.defaultApplications = {
      "image/jpeg" = ["qimgv.desktop"];
      "image/jpg" = ["qimgv.desktop"];
      "image/png" = ["qimgv.desktop"];
    };
  };
}
