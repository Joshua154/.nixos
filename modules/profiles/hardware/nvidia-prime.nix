{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./nvidia.nix];

  # NVIDIA Prime configuration for laptops with hybrid graphics
  hardware.nvidia.prime = {
    # Bus IDs - these need to be customized per device
    # Find with: nix-shell -p pciutils --run "lspci | grep -E 'VGA|3D'"
    amdgpuBusId = lib.mkDefault "PCI:5:0:0";
    nvidiaBusId = lib.mkDefault "PCI:1:0:0";

    # Offload mode - NVIDIA GPU is used on-demand
    offload = {
      enable = lib.mkForce true;
      enableOffloadCmd = lib.mkForce true;
    };

    # Sync mode - always use NVIDIA GPU (better performance, worse battery)
    # sync.enable = lib.mkDefault false;
  };

  # TLP settings for better battery management
  services.tlp = {
    enable = lib.mkDefault true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
    };
  };

  services.power-profiles-daemon.enable = lib.mkForce false;
}
