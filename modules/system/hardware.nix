{hostname, ...}: {
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          Name = hostname;
          ControllerMode = "dual";
          FastConnectable = "true";
          Experimental = "true";
          Enable = "Source,Sink,Media,Socket";
        };

        Policy = {
          AutoEnable = "true";
        };
      };
    };

    keyboard.qmk.enable = true;

    nfc-nci = {
      enable = true;
      enableIFD = true;
    };
  };

  services.pcscd.enable = true;
  environment.systemPackages = with pkgs; [
    pcsctools
  ];
}
