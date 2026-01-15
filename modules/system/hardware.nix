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
  };
}
