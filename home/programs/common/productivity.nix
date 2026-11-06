{pkgs, ...}: {
  home.packages = with pkgs; [
    anki
    beeper
    bitwarden-desktop
    bws
    bluemail
    gh
    morgen
    obsidian
    pdfarranger
    t3code
    teams-for-linux
    thunderbird
    zathura
  ];
}
