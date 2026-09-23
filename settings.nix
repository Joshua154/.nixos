{
  system = "x86_64-linux";
  stateVersion = "25.05";
  theme = "balcony";

  user = {
    name = "joshua";
    fullName = "Joshua Neunert";
    email = "joshua.neunert@gmail.com";
  };

  localization = {
    timeZone = "Europe/Berlin";
    defaultLocale = "en_US.UTF-8";
    regionalLocale = "de_DE.UTF-8";
  };

  permittedInsecurePackages = [
    "electron-39.8.10"
    "openssl-1.1.1w"
    "xpdf-4.05"
  ];

  hosts = {
    laptop = {
      profiles = {
        boot = "systemd-boot";
        hardware = [
          "intel"
          "displaylink"
        ];
        networking = [
          "networkmanager"
          "openconnect"
        ];
        displayManager = "gdm";
        desktops = [
          "hyprland"
          "gnome"
        ];
        programs = ["kdeconnect"];
        services = [
          "syncthing"
          "nfc"
        ];
      };

      nixLd = true;
      hyprland = {
        battery = true;
      };
    };

    desktop = {
      profiles = {
        boot = "secure-boot";
        hardware = [
          "intel"
          "nvidia"
        ];
        networking = [
          "networkmanager"
          "openconnect"
        ];
        displayManager = "gdm";
        desktops = [
          "gnome"
          "hyprland"
        ];
        programs = ["kdeconnect"];
        services = ["syncthing"];
      };

      nixLd = false;
      hyprland = {
        battery = false;
      };
    };
  };
}
