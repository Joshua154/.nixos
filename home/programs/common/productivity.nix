{pkgs, ...}: {
  home.packages = with pkgs; [
    beeper
    bitwarden-desktop
    bws
    bluemail
    obsidian
    pdfarranger
    # pureref
    teams-for-linux
    thunderbird
    zathura
  ];
}
