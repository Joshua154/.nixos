{
  inputs,
  theme,
  ...
}: {
  imports = [inputs.caelestia-shell.homeManagerModules.default];

  programs.caelestia = {
    enable = true;
    # Starts with the Hyprland session (wayland.systemd.target).
    systemd = {
      enable = true;
      environment = [
        # Icon theme for quickshell; without it icons render as missing (checkerboard).
        "QS_ICON_THEME=${theme.iconTheme}"
      ];
    };
    settings = {
      paths.wallpaperDir = "~/Pictures/wallpaper";
    };
    cli.enable = true;
  };
}
