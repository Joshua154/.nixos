{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    zoxide
    gromit-mpx
    direnv
    unzip
    gnumake42

    fzf

    obsidian
    pureref
    pdfarranger
    zathura
    termius
    kdePackages.kdeconnect-kde
    gnomeExtensions.gsconnect
    celluloid
    thunderbird
    bitwarden
    httpie-desktop
    burpsuite

    # jetbrains-toolbox
    jetbrains.gateway
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.ruby-mine
    jetbrains.webstorm
    jetbrains.clion
    jetbrains.datagrip
    jetbrains.goland

    qemu
    spice
    spice-gtk
    virt-viewer
    virt-manager

    #steam
    spotify
    youtube-music
    prismlauncher
    legendary-gl
    wineWowPackages.stable

    teams-for-linux
    beeper
    bluemail

    activitywatch
  ];

  programs = {
    feh.enable = true;
    zoxide.enable = true;

    git = {
      enable = true;
      userEmail = "joshua.neunert@gmail.com";
      userName = "Joshua Neunert";
    };
  };

  services = {
    network-manager-applet.enable = true;
    copyq.enable = true;
  };
}
