{ config, pkgs, ... }:

{
  imports = [
    ./zsh
  ];

  home.packages = with pkgs; [
    neofetch
    htop
    btop
    fd
    ripgrep
  ];
}