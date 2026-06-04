{pkgs, ...}: {
  home.packages = with pkgs; [
    beeper
    bitwarden-desktop
    bluemail
    obsidian
    pdfarranger
    # pureref
    teams-for-linux
    thunderbird
    zathura
  ];
}
