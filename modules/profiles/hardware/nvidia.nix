{
  config,
  pkgs,
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
      # Preserve VRAM across sleep and install NVIDIA's suspend/resume hooks.
      # Without this, Hyprland and other GPU clients can crash after resume.
      enable = true;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      finegrained = false;
    };

    # Back up VRAM on disk, with enough space even if /tmp becomes a tmpfs.
    moduleParams.nvidia.NVreg_TemporaryFilePath = "/var/tmp";

    # Use the NVidia open source kernel module
    # Support is limited to Turing and later architectures
    open = false;

    # Enable the Nvidia settings menu
    nvidiaSettings = true;

    # Select the appropriate driver version
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # GPU persistence is independent of suspend/resume memory preservation.
    nvidiaPersistenced = false;
  };
}
