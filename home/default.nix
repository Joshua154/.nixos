{
  lib,
  pkgs,
  settings,
  ...
}: let
  themes = import ./themes;
  theme =
    themes.${settings.theme}
    or (throw "Unknown theme '${settings.theme}'. Available themes: ${lib.concatStringsSep ", " (builtins.attrNames themes)}");
in {
  imports = [
    ./programs
    ./shell
    ./windowManager
  ];

  _module.args = {inherit theme;};

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
