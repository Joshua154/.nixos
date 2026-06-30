{lib, ...}: {
  boot.loader = {
    efi = {
      canTouchEfiVariables = lib.mkForce false;
      efiSysMountPoint = lib.mkDefault "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = ["nodev"];
    };
    systemd-boot.enable = lib.mkForce false;
  };
}
