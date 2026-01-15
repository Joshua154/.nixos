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
  };
}
