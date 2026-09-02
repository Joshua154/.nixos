{
  config,
  host,
  lib,
  modulesPath,
  settings,
  ...
}: let
  hardware = host.hardware or {};
  cpuVendor = hardware.cpuVendor or null;
in {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    initrd.availableKernelModules = hardware.initrd.availableKernelModules or [];
    initrd.kernelModules = hardware.initrd.kernelModules or [];
    kernelModules = hardware.kernelModules or [];
    extraModulePackages = hardware.extraModulePackages or [];
  };

  fileSystems = hardware.fileSystems or {};
  swapDevices = hardware.swapDevices or [];
  nixpkgs.hostPlatform = lib.mkDefault settings.system;

  hardware.cpu = lib.optionalAttrs (cpuVendor != null) {
    ${cpuVendor}.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  assertions = [
    {
      assertion = builtins.elem cpuVendor [null "amd" "intel"];
      message = "Host CPU vendor must be 'amd', 'intel', or null.";
    }
    {
      assertion = hardware.fileSystems or {} != {};
      message = "Host hardware.fileSystems is empty; configure it in config/private.nix.";
    }
  ];
}
