{ config, pkgs, lib, ... }:

{
  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # AMD GPU driver
  services.xserver.videoDrivers = [ "amdgpu" ];

  # AMD specific options
  boot.initrd.kernelModules = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    radeontop
    clinfo
  ];

  # Better performance for AMD
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
}
