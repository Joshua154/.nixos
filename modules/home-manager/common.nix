{ config, pkgs, ... }:

{
  imports = [
    ./zsh
    ./git.nix
  ];

  home.packages = with pkgs; [
    neofetch
    htop
    btop
    fd
    ripgrep
  ];
}