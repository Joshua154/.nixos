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
    git-lfs

    vulkan-tools
    vulkan-loader
    vulkan-validation-layers

    pandora-launcher

    ethtool

    gimp
    samba

    btop

    freerdp
    usbutils
  ];

  environment.etc."current_system_packages".text = let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;
}
