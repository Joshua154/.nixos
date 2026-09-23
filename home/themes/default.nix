let
  kurzgesagtWallpaperDirectory = builtins.path {
    path = ../images/wallpaper/kurzgesagt-wallpapers;
    name = "kurzgesagt-wallpapers";
  };
  kurzgesagtWallpaper = name: "${kurzgesagtWallpaperDirectory}/${name}";
in {
  balcony = {
    displayName = "Balcony";
    dark = true;
    accentName = "blue";
    gtkTheme = "adw-gtk3-dark";
    iconTheme = "Papirus-Dark";
    cursor = {
      name = "Bibata-Modern-Ice";
      size = 22;
    };
    wallpapers = {
      lock = kurzgesagtWallpaper "Asteroids.png";
      default = kurzgesagtWallpaper "Galaxy_2.png";
    };
    gnomeShellTheme = "Orchis-Purple-Dark-Compact";
    colors = {
      background = "0f1020";
      surface = "1a1b2e";
      overlay = "2b2d47";
      foreground = "e8eaf6";
      muted = "969ab8";
      accent = "7aa2f7";
      secondary = "bb9af7";
      red = "ff7a93";
      yellow = "e9c46a";
      green = "73daca";
    };
  };

  catppuccin-mocha = {
    displayName = "Catppuccin Mocha";
    dark = true;
    accentName = "purple";
    gtkTheme = "adw-gtk3-dark";
    iconTheme = "Papirus-Dark";
    cursor = {
      name = "Bibata-Modern-Ice";
      size = 22;
    };
    wallpapers = {
      lock = ../images/wallpaper/nix-wallpaper-nineish-catppuccin-mocha-alt.png;
      default = ../images/wallpaper/nix-wallpaper-nineish-catppuccin-mocha-alt.png;
    };
    gnomeShellTheme = "Orchis-Purple-Dark-Compact";
    colors = {
      background = "1e1e2e";
      surface = "313244";
      overlay = "45475a";
      foreground = "cdd6f4";
      muted = "9399b2";
      accent = "cba6f7";
      secondary = "89b4fa";
      red = "f38ba8";
      yellow = "f9e2af";
      green = "a6e3a1";
    };
  };
}
