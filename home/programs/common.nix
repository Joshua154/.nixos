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
    bitwarden-desktop
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
      settings.user = {
        email = "joshua.neunert@gmail.com";
        name = "Joshua Neunert";
      };
    };
  };

  services = {
    network-manager-applet.enable = true;
    copyq.enable = true;
  };
}
