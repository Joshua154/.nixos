{ config, pkgs, lib, ... }:

{
  # Base graphics configuration
  # For specific GPU configurations, use:
  # - modules/profiles/hardware/nvidia.nix
  # - modules/profiles/hardware/amd.nix
  # - modules/profiles/hardware/intel.nix

  services.xserver = {
    enable = lib.mkDefault true;
    xkb.layout = "us";
  };

  # Enable OpenGL by default
  hardware.graphics = {
    enable = lib.mkDefault true;
    enable32Bit = lib.mkDefault true;
  };
}
