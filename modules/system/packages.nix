{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vim
    curl
    git

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
    samba

    btop-cuda

    freerdp
    # inputs.winboat.packages.${system}.winboat
    usbutils

    cloudflared
  ];

  environment.etc."current_system_packages".text = let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;
}
