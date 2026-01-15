{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs_22
    burpsuite
    httpie-desktop
    termius

    # Development Environments
    python313
    jdk17_headless
    gradle
    texlive.combined.scheme-full
    vscode

    # JetBrains
    jetbrains.gateway
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.ruby-mine
    jetbrains.webstorm
    jetbrains.clion
    jetbrains.datagrip
    jetbrains.goland
  ];
}
