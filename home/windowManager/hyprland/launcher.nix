{
  pkgs,
  theme,
  ...
}: let
  c = theme.colors;
in {
  xdg.configFile = {
    "rofi/config.rasi".text = ''
      configuration {
        modi: "drun,run,window";
        show-icons: true;
        sidebar-mode: true;
        matching: "fuzzy";
        sorting-method: "fzf";
        hover-select: true;
        drun-display-format: "{name}";
        display-drun: "Applications";
        display-run: "Commands";
        display-window: "Windows";
      }

      * {
        background: #${c.background}f5;
        surface: #${c.surface}fa;
        card: #${c.surface}cc;
        overlay: #${c.overlay};
        foreground: #${c.foreground};
        muted: #${c.muted};
        accent: #${c.accent};
        accent-soft: #${c.accent}24;
      }

      window {
        location: center;
        anchor: center;
        width: 760px;
        border: 1px;
        border-color: @overlay;
        border-radius: 24px;
        background-color: @background;
      }

      mainbox {
        children: [ inputbar, listview, mode-switcher ];
        padding: 24px;
        spacing: 16px;
        background-color: transparent;
      }

      inputbar {
        children: [ textbox-prompt-colon, entry, case-indicator ];
        padding: 10px;
        spacing: 10px;
        border: 1px;
        border-color: @overlay;
        border-radius: 16px;
        background-color: @surface;
      }

      textbox-prompt-colon {
        str: "󰍉";
        padding: 7px 9px;
        border-radius: 10px;
        background-color: @accent-soft;
        text-color: @accent;
      }

      entry {
        padding: 0 5px;
        placeholder: "Search apps, commands, and windows…";
        placeholder-color: @muted;
        text-color: @foreground;
      }

      case-indicator {
        padding: 6px 9px;
        border-radius: 9px;
        background-color: @accent-soft;
        text-color: @accent;
      }

      listview {
        lines: 6;
        columns: 2;
        fixed-height: true;
        fixed-columns: true;
        cycle: true;
        scrollbar: false;
        spacing: 10px;
        background-color: transparent;
      }

      element {
        orientation: horizontal;
        padding: 13px;
        spacing: 14px;
        border: 1px;
        border-color: @overlay;
        border-radius: 16px;
        background-color: @card;
        text-color: @foreground;
      }

      element normal.normal,
      element alternate.normal,
      element normal.active,
      element alternate.active,
      element normal.urgent,
      element alternate.urgent {
        background-color: @card;
        text-color: @foreground;
      }

      element selected.normal,
      element selected.active,
      element selected.urgent {
        border-color: @accent;
        background-color: @accent-soft;
        text-color: @foreground;
      }

      element-icon {
        size: 36px;
        background-color: transparent;
      }

      element-text {
        vertical-align: 0.5;
        background-color: transparent;
        text-color: inherit;
        highlight: @accent;
      }

      mode-switcher {
        spacing: 9px;
        background-color: transparent;
      }

      button {
        padding: 8px 14px;
        border: 1px;
        border-color: transparent;
        border-radius: 11px;
        background-color: @card;
        text-color: @muted;
      }

      button selected {
        border-color: @accent;
        background-color: @accent-soft;
        text-color: @accent;
      }

      message {
        padding: 14px;
        border: 1px;
        border-color: @overlay;
        border-radius: 14px;
        background-color: @surface;
        text-color: @foreground;
      }
    '';

    "wlogout/layout".text = ''
      {
        "label" : "lock",
        "action" : "loginctl lock-session",
        "text" : "Lock",
        "keybind" : "l"
      }
      {
        "label" : "suspend",
        "action" : "systemctl suspend",
        "text" : "Sleep",
        "keybind" : "s"
      }
      {
        "label" : "hibernate",
        "action" : "systemctl hibernate",
        "text" : "Hibernate",
        "keybind" : "h"
      }
      {
        "label" : "logout",
        "action" : "hyprctl dispatch exit",
        "text" : "Log out",
        "keybind" : "e"
      }
      {
        "label" : "reboot",
        "action" : "systemctl reboot",
        "text" : "Restart",
        "keybind" : "r"
      }
      {
        "label" : "shutdown",
        "action" : "systemctl poweroff",
        "text" : "Power off",
        "keybind" : "p"
      }
    '';

    "wlogout/style.css".text = ''
      * {
        font-family: "Noto Sans", "JetBrainsMono Nerd Font";
        font-size: 16px;
        background-image: none;
        box-shadow: none;
      }

      window {
        background-color: alpha(#${c.background}, 0.86);
      }

      button {
        margin: 9px;
        padding: 110px 12px 18px;
        border: 1px solid #${c.overlay};
        border-radius: 22px;
        color: #${c.foreground};
        background-color: alpha(#${c.surface}, 0.94);
        background-repeat: no-repeat;
        background-position: center 38%;
        background-size: 54px;
        transition: background-color 180ms ease, border-color 180ms ease;
      }

      button:focus,
      button:active,
      button:hover {
        outline-style: none;
        border-color: #${c.accent};
        color: #${c.accent};
        background-color: #${c.overlay};
      }

      #lock {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }

      #suspend {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
      }

      #logout {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }

      #reboot {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }

      #shutdown {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }

      #shutdown:hover,
      #shutdown:focus {
        border-color: #${c.red};
        color: #${c.red};
      }
    '';
  };
}
