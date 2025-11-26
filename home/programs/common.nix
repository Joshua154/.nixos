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
    discord

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
