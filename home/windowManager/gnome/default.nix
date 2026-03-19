{
  pkgs,
  ...
}: rec {
  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
    copyous
    gsconnect
    removable-drive-menu
    bluetooth-quick-connect
    coverflow-alt-tab
    panel-corners
    # rounded-window-corners
    custom-hot-corners-extended
    gtile
    tailscale-status
    color-picker
    user-themes
  ];

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = (map (extension: extension.extensionUuid) home.packages)
    ++ 
    [
      "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
      "window-list@gnome-shell-extensions.gcampax.github.com"
      "places-menu@gnome-shell-extensions.gcampax.github.com"
      "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      "apps-menu@gnome-shell-extensions.gcampax.github.com"
      "native-window-placement@gnome-shell-extensions.gcampax.github.com"
      "user-theme@gnome-shell-extensions.gcampax.github.com"
    ]; 
    "org/gnome/shell".disabled-extensions = [];
    "org/gnome/shell/extensions/apps-menu" = { enabled = true; };
        
    # Configure blur-my-shell
    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.85;
      dash-opacity = 0.25;
      sigma = 15; # Sigma means blur amount
      static-blur = true;
    };
    "org/gnome/shell/extensions/blur-my-shell/panel".blur = false;
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      blur = true;
      style-dialogs = 0;
    };

    # Configure GSConnect
    "org/gnome/shell/extensions/gsconnect".show-indicators = true;

    # Configure Copyous
    "org/gnome/shell/extensions/copyous" = {
      global-shortcut = ["<Super>comma"];
      incognito-shortcut = ["<Shift><Super>less"];
    };

    # Configure Bluetooth Quick Connect
    "org/gnome/shell/extensions/bluetooth-quick-connect" = {
      keep-menu-on-toggle = true;
      refresh-button-on = true;
      show-batter-icon-on = true;
    };

    # Configure Panel Corners
    "org/gnome/shell/extensions/panel-corners" = {
      panel-corner-background-color = "rgb(0,0,0)";
      panel-corner-opacity = 1;
      panel-corners = true;
      screen-corners = true;
    };

    # Configure Rounded Window Corners
    "org/gnome/shell/extensions/rounded-window-corners" = {
      tweak-kitty-terminal = true;
    };

    # Configure Extended Hot Corners
    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-0" = {
      action = "toggle-overview";
    };
    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-1" = {
      action = "move-win-to-prev-ws";
    };
    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-left-6" = {  
      action = "show-applications";
      ctrl = true;
    };
    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-right-1" = {
      action = "move-win-to-next-ws";
      fullscreen = true;
    };
    "org/gnome/shell/extensions/custom-hot-corners-extended/monitor-0-top-right-6" = {
      ctrl = true;
    };

    # Configure Color Picker
    "org/gnome/shell/extensions/color-picker" = {
      enable-shortcut = true;
      color-picker-shortcut = ["<Shift><Super>c"];
    };

    # Configure Clipboard History
    "org/gnome/shell/extensions/clipboard-history" = {
      history-size = 100000;
      private-mode = false;
      display-mode = 0;
    };

    # The open applications bar
    "org/gnome/shell/extensions/window-list" = {
      grouping-mode = "always";
      show-on-all-monitors = true;
      display-all-workspaces = true;
    };

    # Set the Shell Theme
    "org/gnome/shell/extensions/user-theme" = {
      name = "Marble-purple-dark";
    };

    # Interface Settings
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      accent-color = "purple";
      cursor-theme = "Bibata-Modern-Ice";
      cursor-size = 22;
      icon-theme = "Papirus-Dark";
      gtk-theme = "Adwaita:dark";
      clock-show-seconds = true;
      clock-show-weekday = false;
      clock-show-date = true; # Retained from original
      toolkit-accessibility = true;
      monospace-font-name = "RobotoMono Nerd Font 10"; # Retained from original
      font-antialiasing = "rgba"; # Retained from original
    };

    # Keybindings
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = ["<Shift><Super>s"];
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = ["<Super>Tab"];
      switch-applications-backward = ["<Shift><Super>Tab"];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
    };

    # Window Manager Preferences
    "org/gnome/desktop/wm/preferences" = {
      workspace-names = [
        "Browser"
        "Code"
        "Chat"
      ];
      button-layout = "appmenu:maximize,close";
    };

    # Mutter
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      workspaces-only-on-primary = false;
    };

    # Input & Peripherals
    "org/gnome/desktop/input-sources" = {
      xkb-options = ["terminate:ctrl_alt_bksp"];
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    # Application Defaults: Text Editor
    "org/gnome/TextEditor" = {
      show-line-numbers = true;
      style-scheme = "classic-dark";
      wrap-text = false;
    };

    # Application Defaults: Nautilus / File Manager
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      search-filter-time-type = "last_modified";
    };
    "org/gnome/nautilus/list-view" = {
      default-zoom-level = "small";
      default-visible-columns = ["name" "size" "date_modified"];
    };
    
    # File Chooser
    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "com.mitchellh.ghostty.desktop"
        "discord.desktop"
        "firefox.desktop"
        "beepertexts.desktop"
        "spotify.desktop"
      ];
    };
  };
}