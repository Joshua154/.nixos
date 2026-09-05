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
        # wallpaper accepts a one-based theme catalog ID or a path string.
        # Example: wallpaper = "home/images/wallpaper/main_menu_background.png";
        monitors = [
          {
            output = "eDP-1";
            # mode = "1920x1080@60";
            position = "0x0";
            scale = 1;
            wallpaper = 4;
          }
        ];
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
        monitors = [
          # Fallback for docks and newly attached outputs.
          {
            output = "";
            mode = "highrr";
            position = "auto";
            scale = 1;
          }
          {
            output = "DP-2";
            mode = "2560x1440@180";
            position = "0x0";
            scale = 1;
            wallpaper = 21;
          }
          {
            output = "DP-3";
            mode = "2560x1440@180";
            position = "2560x0";
            scale = 1;
            wallpaper = 7;
          }
        ];
        battery = false;
      };
    };
  };
}
