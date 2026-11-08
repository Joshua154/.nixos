{
  inputs,
  pkgs,
  theme,
  ...
}: {
  imports = [inputs.caelestia-shell.homeManagerModules.default];

  programs.caelestia = {
    enable = true;
    # package = inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli.overrideAttrs (old: {
    #   postPatch =
    #     (old.postPatch or "")
    #     + ''
    #       substituteInPlace modules/bar/components/Clock.qml \
    #         --replace-fail 'import QtQuick.Layouts' $'import Quickshell\nimport QtQuick.Layouts' \
    #         --replace-fail '    ColumnLayout {' $'    TapHandler {\n        onTapped: Quickshell.execDetached(["morgen"])\n    }\n\n    ColumnLayout {'
    #     '';
    # });
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
      # Hypridle owns these timeouts so the shell does not run a second set.
      general.idle = {
        lockBeforeSleep = false;
        timeouts = [];
      };
    };
    cli.enable = true;
  };
}
