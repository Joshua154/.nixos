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
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };

  # nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    enableRedistributableFirmware = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      # Nvidia power management. Experimental, can cause sleep/suspend issues.
      # Enable if you have graphical corruption or crashes after waking from sleep.
      enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      finegrained = false;
    };

    # Use the NVidia open source kernel module
    # Support is limited to Turing and later architectures
    # Currently alpha-quality/buggy, so false is recommended
    open = false;

    # Enable the Nvidia settings menu
    nvidiaSettings = true;

    # Select the appropriate driver version
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Prevent NVIDIA from being suspended
    nvidiaPersistenced = false;
  };

  # Fix Wayland cursor issues with NVIDIA
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Enable thermald for better thermal management
  services.thermald.enable = lib.mkDefault true;
}
