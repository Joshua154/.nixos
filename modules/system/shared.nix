# Shared configuration modules that are common across all hosts
{
  config,
  pkgs,
  lib,
  ...
}: {
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
    ./tailscale.nix
    ./users.nix
    ./virtualisation.nix
  ];

  # Graphics configuration - default without specific GPU
  services.xserver.enable = lib.mkDefault true;

  # XDG Portal configuration
  xdg = {
    portal = {
      enable = true;
      extraPortals = lib.mkDefault [pkgs.xdg-desktop-portal-gtk];
      config.common.default = lib.mkDefault "*";
    };
    mime.defaultApplications = {
      "image/jpeg" = ["qimgv.desktop"];
      "image/jpg" = ["qimgv.desktop"];
      "image/png" = ["qimgv.desktop"];
    };
  };
}
