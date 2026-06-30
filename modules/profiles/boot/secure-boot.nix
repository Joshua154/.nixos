{
  lanzaboote,
  lib,
  ...
}: {
  imports = [
    lanzaboote.nixosModules.lanzaboote
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = lib.mkDefault true;
      systemd-boot.enable = lib.mkForce false;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
