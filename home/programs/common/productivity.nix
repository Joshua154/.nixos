{pkgs, ...}: {
  home.packages = with pkgs; [
    anki
    beeper
    bitwarden-desktop
    bws
    bluemail
    morgen
    obsidian
    pdfarranger
    # pureref
    teams-for-linux
    thunderbird
    zathura
  ];
}
