{...}: {
  imports = [
    ../../modules/system/shared.nix
    ../../modules/system/syncthing.nix

    ./hardware-configuration.nix

    ../../modules/profiles/boot/systemd-boot.nix
    ../../modules/profiles/hardware/intel.nix
    ../../modules/profiles/networking/networkmanager.nix

    # ../../modules/profiles/display-managers/ly.nix
    ../../modules/profiles/display-managers/gdm.nix
    # ../../modules/profiles/display-managers/sddm.nix

    # ../../modules/profiles/window-managers/hyprland.nix
    # ../../modules/profiles/window-managers/bspwm.nix
    ../../modules/profiles/window-managers/gnome.nix
    # ../../modules/profiles/window-managers/qtile.nix

    ../../modules/profiles/programs/kdeconnect.nix
  ];

  # services.tlp.enable = true;
  powerManagement.enable = true;

  programs.nix-ld.enable = true;

  system.stateVersion = "25.05";
}
