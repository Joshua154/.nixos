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
      height = 46;
      margin-top = 8;
      margin-left = 10;
      margin-right = 10;
      spacing = 8;
      modules-left = [
        "custom/launcher"
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-center = ["group/center"];
      modules-right =
        [
          "group/status"
        ]
        ++ [
          "custom/notifications"
          "custom/power"
        ];

      "group/center" = {
        orientation = "horizontal";
        modules = [
          "mpris"
          "clock"
        ];
      };
      "group/status" = {
        orientation = "horizontal";
        modules =
          [
            "idle_inhibitor"
            "tray"
            "network"
            "pulseaudio"
            "backlight"
          ]
          ++ lib.optional host.hyprland.battery "battery";
      };

      "custom/launcher" = {
        format = "  Apps";
        tooltip-format = "Open application launcher  Super + Space";
        on-click = "rofi -show drun";
      };
      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        persistent-workspaces."*" = 5;
        format-icons = {
          active = "●";
          default = "●";
          urgent = "●";
        };
      };
      "hyprland/window" = {
        format = "{title}";
        icon = true;
        icon-size = 16;
        max-length = 42;
        rewrite = {
          "(.*) — Mozilla Firefox" = "$1";
          "(.*) - Visual Studio Code" = "$1";
          "" = "Desktop";
        };
        separate-outputs = true;
      };
      mpris = {
        format = "{player_icon} {dynamic}";
        format-paused = "{status_icon} {dynamic}";
        dynamic-order = [
          "title"
          "artist"
        ];
        dynamic-len = 28;
        player-icons.default = "󰎆";
        status-icons.paused = "󰏤";
        on-click = "playerctl play-pause";
        on-click-middle = "playerctl previous";
        on-click-right = "playerctl next";
        tooltip-format = "{player}: {dynamic}";
      };
      clock = {
        format = "{:%H:%M  ·  %a %d}";
        format-alt = "{:%A, %d %B %Y  ·  %H:%M}";
        tooltip-format = "<big><b>{:%B %Y}</b></big>\n<tt><small>{calendar}</small></tt>";
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "󰅶";
          deactivated = "󰾪";
        };
        tooltip-format-activated = "Idle lock paused";
        tooltip-format-deactivated = "Allow idle lock";
      };
      tray = {
        icon-size = 16;
        spacing = 8;
      };
      network = {
        format-wifi = "{icon}";
        format-ethernet = "󰈀";
        format-disconnected = "󰤭";
        format-icons = [
          "󰤯"
          "󰤟"
          "󰤢"
          "󰤥"
          "󰤨"
        ];
        tooltip-format-wifi = "{essid}  ·  {signalStrength}%\n{ipaddr}";
        tooltip-format-ethernet = "Wired  ·  {ifname}\n{ipaddr}";
        tooltip-format-disconnected = "Network disconnected";
        on-click = "nm-connection-editor";
      };
      pulseaudio = {
        format = "{icon}";
        format-muted = "󰝟";
        format-icons.default = [
          ""
          ""
          ""
        ];
        tooltip-format = "Volume {volume}%";
        on-click = "pavucontrol";
        on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        scroll-step = 5;
      };
      backlight = {
        format = "󰃠";
        tooltip-format = "Brightness {percent}%";
        on-scroll-up = "brightnessctl set +5%";
        on-scroll-down = "brightnessctl set 5%-";
      };
      battery = {
        interval = 30;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon}  {capacity}%";
        format-charging = "󰂄  {capacity}%";
        tooltip-format = "{timeTo}  ·  {power:.1f} W";
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
      "custom/notifications" = {
        format = "󰂚";
        tooltip-format = "Left: show previous notification\nRight: clear notifications";
        on-click = "dunstctl history-pop";
        on-click-right = "dunstctl close-all";
      };
      "custom/power" = {
        format = "󰐥";
        tooltip-format = "Session menu  Super + Shift + E";
        on-click = "wlogout -b 3 -L 300 -R 300 -T 220 -B 220";
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: "Noto Sans", "JetBrainsMono Nerd Font";
        font-size: 13px;
      }

      window#waybar {
        background: transparent;
        color: #${c.foreground};
      }

      .modules-left,
      .modules-center,
      .modules-right {
        margin: 0;
      }

      #custom-launcher,
      #workspaces,
      #window,
      #center,
      #status,
      #custom-notifications,
      #custom-power {
        min-height: 38px;
        border: 1px solid alpha(#${c.overlay}, 0.82);
        border-radius: 15px;
        background: alpha(#${c.surface}, 0.93);
        box-shadow: 0 3px 12px alpha(#${c.background}, 0.45);
      }

      #custom-launcher {
        padding: 0 15px 0 13px;
        color: #${c.accent};
        font-weight: 700;
      }

      #custom-launcher:hover,
      #custom-notifications:hover,
      #custom-power:hover,
      #idle_inhibitor:hover,
      #network:hover,
      #pulseaudio:hover,
      #backlight:hover,
      #battery:hover {
        background: alpha(#${c.overlay}, 0.95);
      }

      #workspaces {
        padding: 0 7px;
      }

      #workspaces button {
        min-width: 12px;
        padding: 0 4px;
        color: #${c.overlay};
        font-size: 10px;
        transition: color 180ms ease, min-width 180ms ease;
      }

      #workspaces button:hover {
        color: #${c.muted};
        background: transparent;
        box-shadow: none;
        text-shadow: none;
      }

      #workspaces button.active {
        min-width: 27px;
        color: #${c.accent};
      }

      #workspaces button.urgent {
        color: #${c.red};
      }

      #window {
        padding: 0 13px;
        color: #${c.muted};
      }

      window#waybar.empty #window {
        background: transparent;
        border-color: transparent;
        box-shadow: none;
      }

      #center,
      #status {
        padding: 0 5px;
      }

      #mpris {
        padding: 0 10px;
        color: #${c.secondary};
      }

      #mpris.paused {
        color: #${c.muted};
      }

      #clock {
        padding: 0 11px;
        color: #${c.foreground};
        font-weight: 700;
      }

      #idle_inhibitor,
      #tray,
      #network,
      #pulseaudio,
      #backlight,
      #battery {
        min-width: 18px;
        padding: 0 8px;
        border-radius: 10px;
      }

      #tray {
        padding: 0 7px;
      }

      #idle_inhibitor.activated {
        color: #${c.yellow};
      }

      #network {
        color: #${c.green};
      }

      #network.disconnected,
      #pulseaudio.muted,
      #battery.critical:not(.charging) {
        color: #${c.red};
      }

      #pulseaudio {
        color: #${c.accent};
      }

      #backlight {
        color: #${c.yellow};
      }

      #battery {
        color: #${c.green};
      }

      #battery.warning:not(.charging) {
        color: #${c.yellow};
      }

      #custom-notifications,
      #custom-power {
        min-width: 38px;
        padding: 0;
        font-size: 16px;
      }

      #custom-notifications {
        color: #${c.secondary};
      }

      #custom-power {
        color: #${c.red};
      }

      tooltip {
        border: 1px solid #${c.overlay};
        border-radius: 13px;
        background: alpha(#${c.background}, 0.96);
        box-shadow: 0 6px 20px alpha(#${c.background}, 0.55);
      }

      tooltip label {
        padding: 8px;
        color: #${c.foreground};
      }
    '';
  };
}
