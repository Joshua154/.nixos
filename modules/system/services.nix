{pkgs, ...}: {
  services = {
    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;

    blueman.enable = true;
    udev.packages = [pkgs.via];
    flatpak.enable = true;
    libinput = {
      enable = true;

      touchpad = {
        tapping = true;
        middleEmulation = true;
      };
    };
  };

  # Enable mDNS for discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
