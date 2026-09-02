{
  user = {
    name = "your-user";
    fullName = "Your Name";
    email = "you@example.com";
  };

  localization = {
    timeZone = "Region/City";
    regionalLocale = "en_US.UTF-8";
  };

  hosts.my-host = {
    profiles = {
      boot = "systemd-boot";
      hardware = ["intel"];
      networking = ["networkmanager"];
      displayManager = "gdm";
      desktops = ["gnome"];
      programs = ["android" "kdeconnect"];
      services = ["localsend" "tailscale"];
    };

    hardware = {
      initrd.availableKernelModules = ["nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = ["kvm-intel"];
      cpuVendor = "intel";
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/REPLACE-ME";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/REPLACE-ME";
          fsType = "vfat";
          options = ["fmask=0022" "dmask=0022"];
        };
      };
    };

    nixLd = false;
    firewall.allowedTCPPorts = [];
    hyprland = {
      monitors = [];
      battery = false;
    };

    # Never put passwords or tokens in Nix files. Point services at credential
    # files outside the Nix store instead.
    syncthing = {
      dataDirectory = "Sync";
      folders = {};
      devices = {};
    };
  };
}
