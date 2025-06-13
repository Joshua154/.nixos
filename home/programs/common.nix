{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    zoxide
    gromit-mpx
    direnv

    obsidian
    termius 
    jetbrains-toolbox
    kdePackages.kdeconnect-kde
    gnomeExtensions.gsconnect
    celluloid
    thunderbird
    bitwarden
    whatsapp-for-linux
    firefox

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
