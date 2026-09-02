let
  kurzgesagtWallpaperDirectory = builtins.path {
    path = ../images/wallpaper/kurzgesagt-wallpapers;
    name = "kurzgesagt-wallpapers";
  };
  kurzgesagtWallpaper = name: "${kurzgesagtWallpaperDirectory}/${name}";

  # `wallpaper = 4` selects Asteroids.png.
  kurzgesagtWallpapers = map kurzgesagtWallpaper [
    "Asteroid_Miner_1.png"
    "Asteroid_Miner_2.png"
    "Asteroid_Miner_3.png"
    "Asteroids.png"
    "Baby_Star.png"
    "Black Hole_1.png"
    "Black Hole_2.png"
    "Black_Hole_3.png"
    "Cloudy Quasar_1.png"
    "Cloudy Quasar_2.png"
    "Contemplative Cosmonaut_1.png"
    "Contemplative Cosmonaut_2.png"
    "Contemplative Cosmonaut_3.png"
    "Contemplative Cosmonaut_4.png"
    "Cosmic_Islands.png"
    "Dyson_Sphere.png"
    "Fleet.png"
    "Galaxies.png"
    "Galaxy_1.png"
    "Galaxy_2.png"
    "Galaxy_3.png"
    "Mars.png"
    "On A Moon.png"
    "Ringed_Earth.jpg"
    "Satellite over Earth.png"
    "Solar System.png"
    "Stars.png"
    "Stellar Phenomenon.png"
    "Unknown Lifeform.png"
    "Alien_Clouds.png"
  ];
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

      screens = kurzgesagtWallpapers;
    };
    gnomeShellTheme = "Orchis-Purple-Dark-Compact";
    colors = {
      background = "1a1b26";
      surface = "252733";
      overlay = "3b4252";
      foreground = "e5e9f0";
      muted = "8a909e";
      accent = "5e81ac";
      secondary = "88c0d0";
      red = "fb958b";
      yellow = "ecd3a0";
      green = "a1c999";
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
      screens = kurzgesagtWallpapers;
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
