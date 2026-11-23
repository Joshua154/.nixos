{ pkgs, ... }:

{
  home.packages = with pkgs; [
    intellij-idea
    pycharm
    datagrip

    # webstorm
    # rust-rover
  ];
}