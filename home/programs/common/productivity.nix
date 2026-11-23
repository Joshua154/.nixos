{pkgs, ...}: {
  home.packages = with pkgs; [
    beeper
    bitwarden-desktop
    bws
    gh
    obsidian
    pdfarranger
    t3code
    teams-for-linux
    thunderbird
    zathura
  ];
}
