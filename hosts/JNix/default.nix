{
  config,
  hostname,
  inputs,
  pkgs,
  system,
  username,
  ...
}: {
  imports = [
    ../../modules/system

    ./boot.nix
    ./grub
    ./hardware-configuration.nix
    ./networking.nix
    ./nvidia.nix
    ./openconnect
    ./zoom.nix
  ];

  programs.kdeconnect.enable = true;

  system.stateVersion = "25.05";
}
