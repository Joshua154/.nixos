{
  host,
  lib,
  pkgs,
  settings,
  ...
}: let
  themes = import ./themes;
  theme =
    themes.${settings.theme}
    or (throw "Unknown theme '${settings.theme}'. Available themes: ${lib.concatStringsSep ", " (builtins.attrNames themes)}");
  customWallpaperName = selection:
    lib.strings.sanitizeDerivationName "custom-wallpaper-${builtins.baseNameOf (toString selection)}";
  customWallpaper = selection:
    if builtins.isPath selection
    then
      toString (builtins.path {
        path = selection;
        name = customWallpaperName selection;
      })
    else if lib.hasPrefix "/" selection
    then selection
    else let
      source = ../. + "/${selection}";
    in
      if builtins.pathExists source
      then
        toString (builtins.path {
          path = source;
          name = customWallpaperName selection;
        })
      else throw "Wallpaper path '${selection}' does not exist relative to the repository root";
  wallpaperFor = monitor: let
    selection = monitor.wallpaper or null;
    choices = theme.wallpapers.screens or [];
    choiceCount = builtins.length choices;
  in
    if selection == null
    then theme.wallpapers.default
    else if builtins.isInt selection
    then
      if selection >= 1 && selection <= choiceCount
      then builtins.elemAt choices (selection - 1)
      else
        throw ''
          Invalid wallpaper ID '${toString selection}' for monitor '${monitor.output}'.
          Theme '${settings.theme}' provides wallpaper IDs 1-${toString choiceCount}; omit the
          monitor's wallpaper attribute to use the theme default.
        ''
    else if builtins.isPath selection || builtins.isString selection
    then customWallpaper selection
    else
      throw ''
        A monitor wallpaper must be a catalog ID or path string, not ${builtins.typeOf selection}.
      '';
  configuredMonitors = host.hyprland.monitors or [];
  wallpaper = {
    inherit (theme.wallpapers) default lock;
    forMonitor = wallpaperFor;
    desktop =
      if configuredMonitors == []
      then theme.wallpapers.default
      else wallpaperFor (builtins.head configuredMonitors);
  };
in {
  imports = [
    ./programs
    ./shell
    ./windowManager
  ];

  _module.args = {inherit theme wallpaper;};

  home = {
    username = settings.user.name;
    homeDirectory = "/home/${settings.user.name}";
    stateVersion = settings.stateVersion;
    enableNixpkgsReleaseCheck = false;

    sessionVariables = {
      XCURSOR_THEME = theme.cursor.name;
      XCURSOR_SIZE = toString theme.cursor.size;
    };

    pointerCursor = {
      enable = true;
      inherit (theme.cursor) name size;
      package = pkgs.bibata-cursors;
      gtk.enable = true;
    };

    file = {
      "Pictures" = {
        source = ./images;
        recursive = true;
      };
    };
  };

  gtk = {
    enable = true;
    gtk4.theme = null;
    theme = {
      name = theme.gtkTheme;
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = theme.iconTheme;
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      inherit (theme.cursor) name size;
      package = pkgs.bibata-cursors;
    };
  };

  programs.home-manager.enable = true;
}
