{
  config,
  pkgs,
  ...
}: {
  boot = {
    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
    kernelModules = [
      "evdi"
      "v4l2loopback"
    ];

    # loader = {
    #   grub = {
    #     enable = true;
    #     efiSupport = true;
    #     efiInstallAsRemovable = true;
    #     devices = ["nodev"];
    #   };
    # };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "bgrt"; # breeze
    };
    kernelParams = ["quiet" "splash"];
  };
}
