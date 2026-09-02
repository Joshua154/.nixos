{
  config,
  pkgs,
  ...
}: {
  boot = {
    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
    kernelModules = [
      "v4l2loopback"
    ];

    plymouth = {
      enable = true;
      theme = "bgrt"; # breeze
    };
    kernelParams = ["quiet" "splash"];
  };
}
