{
  host,
  lib,
  repositoryRoot,
  theme,
  themeName,
}: let
  customWallpaper = selection: let
    name = lib.strings.sanitizeDerivationName "custom-wallpaper-${builtins.baseNameOf (toString selection)}";
    source =
      if builtins.isPath selection || lib.hasPrefix "/" selection
      then selection
      else repositoryRoot + "/${selection}";
  in
    if builtins.pathExists source
    then
      toString (builtins.path {
        path = source;
        inherit name;
      })
    else throw "Wallpaper path '${toString selection}' does not exist";

  forMonitor = monitor: let
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
          Invalid wallpaper ID '${toString selection}' for monitor '${monitor.output or "default"}'.
          Theme '${themeName}' provides wallpaper IDs 1-${toString choiceCount}.
        ''
    else if builtins.isPath selection || builtins.isString selection
    then customWallpaper selection
    else throw "A monitor wallpaper must be a catalog ID or path, not ${builtins.typeOf selection}.";

  monitors = host.hyprland.monitors or [];
in {
  inherit forMonitor;
  inherit (theme.wallpapers) default lock;
  desktop =
    if monitors == []
    then theme.wallpapers.default
    else forMonitor (builtins.head monitors);
}
