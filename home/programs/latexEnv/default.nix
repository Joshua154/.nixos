{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
    texlive.combined.scheme-full
  ];
}
