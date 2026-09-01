{
  host,
  lib,
  theme,
  ...
}: let
  c = theme.colors;
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 38;
      spacing = 4;
      modules-left = [
        "custom/launcher"
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-center = ["clock"];
      modules-right =
        [
          "tray"
          "network"
          "pulseaudio"
          "backlight"
        ]
        ++ lib.optional host.hyprland.battery "battery"
        ++ ["custom/power"];

      "custom/launcher" = {
        format = "";
        tooltip = false;
        on-click = "rofi -show drun";
      };
      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          active = "";
          default = "";
          urgent = "";
        };
      };
      "hyprland/window" = {
        format = "{}";
        max-length = 55;
        separate-outputs = true;
      };
      clock = {
        format = "{:%H:%M}";
        format-alt = "{:%A, %d %B %Y}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
      };
      tray.spacing = 8;
      network = {
        format-wifi = "󰤨  {signalStrength}%";
        format-ethernet = "󰈀";
        format-disconnected = "󰤭";
        tooltip-format = "{ifname}: {ipaddr}";
        on-click = "nm-connection-editor";
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 muted";
        format-icons.default = [
          ""
          ""
          ""
        ];
        on-click = "pavucontrol";
      };
      backlight = {
        format = "󰃠 {percent}%";
        on-scroll-up = "brightnessctl set +5%";
        on-scroll-down = "brightnessctl set 5%-";
      };
      battery = {
        interval = 30;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-icons = [
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
      };
      "custom/power" = {
        format = "⏻";
        tooltip = false;
        on-click = "wlogout";
      };
    };

    style = ''
      * {
        border: none;
        min-height: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
      }

      window#waybar {
        background: alpha(#${c.background}, 0.92);
        color: #${c.foreground};
      }

      #custom-launcher, #workspaces, #window, #clock, #tray,
      #network, #pulseaudio, #backlight, #battery, #custom-power {
        margin: 6px 2px;
        padding: 0 10px;
        border-radius: 9px;
        background: #${c.surface};
      }

      #custom-launcher, #workspaces button.active { color: #${c.accent}; }
      #workspaces button { padding: 0 5px; color: #${c.muted}; }
      #workspaces button.urgent, #battery.critical { color: #${c.red}; }
      #clock { color: #${c.secondary}; font-weight: bold; }
      #custom-power { color: #${c.red}; margin-right: 8px; }
      #window { color: #${c.muted}; }

      tooltip {
        background: #${c.background};
        border: 1px solid #${c.accent};
        border-radius: 9px;
      }
    '';
  };
}
