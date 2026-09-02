{
  lib,
  pkgs,
  ...
}: {
  boot.loader = {
    systemd-boot = {
      enable = lib.mkDefault true;
      configurationLimit = lib.mkDefault 10;

      extraInstallCommands = ''
        ${pkgs.gnused}/bin/sed -i 's/^default .*/default @saved/' /boot/loader/loader.conf
      '';
    };
    efi.canTouchEfiVariables = lib.mkDefault true;
  };
}
