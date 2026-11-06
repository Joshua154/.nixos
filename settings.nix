{
  system = "x86_64-linux";
  # Compatibility defaults for existing data; do not bump with package updates.
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

  openwallpaper.enabled = ["solid" "pulse" "fullscreen-shader"];

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
      openwallpaper.selected = null;
    };

    desktop = {
      profiles = {
        boot = "systemd-boot";
        hardware = [
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
      openwallpaper.selected = null;
    };
  };
}
