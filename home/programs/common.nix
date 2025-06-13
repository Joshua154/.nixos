{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    zoxide
    ghostty
    gromit-mpx
    direnv

    obsidian
    veskt
    #discord
    termius 
    jetbrains-toolbox
    kdePackages.kdeconnect-kde
    gnomeExtensions.gsconnect
    celluloid
    thunderbird
    bitwarden
    whatsapp-for-linux

    #jetbrains.idea-ultimate
    #jetbrains.datagrip
    #jetbrains.pycharm-professional

    qemu
    spice
    spice-gtk
    virt-viewer
    virt-manager

    steam
    spotify
    prismlauncher
    legendary-gl
    wineWowPackages.stable
  ];

  programs = {
    feh.enable = true;
    zoxide.enable = true;
  };

  services = {
    network-manager-applet.enable = true;
    copyq.enable = true;
  };
}
