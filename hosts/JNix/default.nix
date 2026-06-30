{
  config,
  hostname,
  inputs,
  pkgs,
  system,
  username,
  ...
}: {
  imports = [
    ../../modules/system/shared.nix

    # Hardware configuration
    ./hardware-configuration.nix
    ../../modules/profiles/boot/grub-efi-removable.nix
    ./grub
    
    # Hardware-specific profiles
    ../../modules/profiles/hardware/nvidia-prime.nix
    ../../modules/profiles/networking/networkmanager.nix

    # Display Manager
    ../../modules/profiles/display-managers/gdm.nix

    # Window Manager - choose one:
    # ../../modules/profiles/window-managers/hyprland.nix
    # ../../modules/profiles/window-managers/bspwm.nix
    ../../modules/profiles/window-managers/gnome.nix

    # Additional host-specific modules
    ../../modules/profiles/networking/openconnect.nix
    ../../modules/profiles/programs/kdeconnect.nix
    ../../modules/profiles/programs/zoom.nix
  ];

  system.stateVersion = "25.05";
}
