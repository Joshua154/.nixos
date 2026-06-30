{
  config,
  pkgs,
  lib,
  ...
}: {
  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  # Intel GPU driver
  services.xserver.videoDrivers = ["intel"];

  # Intel specific options
  boot.initrd.kernelModules = ["i915"];

  # hardware acceleration
  environment.sessionVariables = {
    VDPAU_DRIVER = "va_gl";
  };
}
