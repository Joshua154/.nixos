# Shared configuration modules that are common across all hosts
{
  pkgs,
  lib,
  settings,
  ...
}: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./graphics.nix
    ./hardware.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./programs.nix
    # ./secrets.nix
    ./services.nix
    ./users.nix
    ./virtualisation.nix
  ];

  system.stateVersion = settings.stateVersion;

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
