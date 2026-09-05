{pkgs, ...}: {
  home.packages = with pkgs; [
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
