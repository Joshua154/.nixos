{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs_22
    burpsuite
    httpie-desktop
    termius

    # Development Environments
    python313
    jdk25
    # gradle
    texlive.combined.scheme-full
    vscode

    # JetBrains
    jetbrains.gateway
    # jetbrains.idea
    jetbrains.pycharm
    # jetbrains.ruby-mine
    # jetbrains.webstorm
    jetbrains.clion
    jetbrains.datagrip
    # jetbrains.goland
    jetbrains.rust-rover

    jetbrains-toolbox

    devenv
    secretspec
  ];
}
