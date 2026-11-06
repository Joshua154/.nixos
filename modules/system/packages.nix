{
  config,
  lib,
  pkgs,
  ...
}: let
  pandora-launcher = import ./overwrites/pandora-launcher.nix {inherit lib pkgs;};
in {
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
    krita
    samba

    btop-cuda

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
