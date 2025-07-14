{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    zoxide
    gromit-mpx
    direnv

    fzf

    obsidian
    termius 
    jetbrains-toolbox
    kdePackages.kdeconnect-kde
    gnomeExtensions.gsconnect
    celluloid
    thunderbird
    bitwarden

    #jetbrains.idea-ultimate
    #jetbrains.datagrip
    #jetbrains.pycharm-professional

    qemu
    spice
    spice-gtk
    virt-viewer
    virt-manager

    #steam
    spotify
    prismlauncher
    legendary-gl
    wineWowPackages.stable
    
    teams-for-linux
    beeper
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
