{ pkgs, ... }:
# let
#   unstable = import <unstable> {};
# in
{
  home.packages = with pkgs; [
    # unstable.vscode
    vscode
    texlive.combined.scheme-full
  ];
}
