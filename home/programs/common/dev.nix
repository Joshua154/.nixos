{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs_22
    burpsuite
    httpie-desktop
    termius

    # Development Environments
    python313
    jdk25
    texliveFull
    vscode

    jetbrains-toolbox

    devenv
  ];
}
