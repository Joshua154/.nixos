{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vim
    curl
    git
    git-lfs

    vulkan-tools
    vulkan-loader
    vulkan-validation-layers

    ethtool

    # hyprland
    #    hyprland
    #    wayland-utils
    #    xwayland
    #    kitty

    gimp
    # krita
    samba

    btop-cuda

    freerdp
    # inputs.winboat.packages.${system}.winboat
    usbutils

    cloudflared

    arduino-ide
  ];

  environment.etc."current_system_packages".text = let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;
}
