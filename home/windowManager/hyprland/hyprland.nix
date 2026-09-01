{
  host,
  lib,
  theme,
  ...
}: let
  c = theme.colors;
  toLua = lib.generators.toLua {};
  renderMonitors = lib.concatMapStringsSep "\n" (monitor: "hl.monitor(${toLua monitor})") host.hyprland.monitors;
  execBind = keys: command: "hl.bind(${toLua keys}, hl.dsp.exec_cmd(${toLua command}))";
  dispatchBind = keys: dispatcher: "hl.bind(${toLua keys}, ${dispatcher})";
  repeatExecBind = keys: command: ''
    hl.bind(${toLua keys}, hl.dsp.exec_cmd(${toLua command}), { locked = true, repeating = true })
  '';
  workspaceBinds = lib.concatMapStringsSep "\n" (i: let
    workspace = toString i;
    key = toString (lib.mod i 10);
  in ''
    hl.bind("SUPER + ${key}", hl.dsp.focus({ workspace = "${workspace}" }))
    hl.bind("SUPER + SHIFT + ${key}", hl.dsp.window.move({ workspace = "${workspace}" }))
  '') (lib.range 1 10);
in {
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = null;
    portalPackage = null;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
    };

    settings.config = {
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";
        touchpad.natural_scroll = true;
      };

      general = {
        layout = "dwindle";
        gaps_in = 6;
        gaps_out = 12;
        border_size = 2;
        col = {
          active_border = {
            colors = [
              "rgba(${c.accent}ff)"
              "rgba(${c.secondary}ff)"
            ];
            angle = 45;
          };
          inactive_border = "rgba(${c.overlay}aa)";
        };
        resize_on_border = true;
      };

      decoration = {
        rounding = 12;
        active_opacity = 0.96;
        inactive_opacity = 0.92;
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
          color = "rgba(${c.background}cc)";
        };
      };

      animations.enabled = true;
      dwindle = {
        preserve_split = true;
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        vrr = true;
      };
      xwayland.force_zero_scaling = true;
      cursor.no_hardware_cursors = true;
    };

    extraConfig = ''
      -- Monitor data is host-specific and comes from settings.nix.
      ${renderMonitors}

      hl.env("XCURSOR_SIZE", ${toLua (toString theme.cursor.size)})
      hl.env("HYPRCURSOR_SIZE", ${toLua (toString theme.cursor.size)})

      hl.curve("easeOut", { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })
      hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "easeOut", style = "popin 80%" })
      hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "easeOut" })
      hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "easeOut", style = "slide" })

      hl.on("hyprland.start", function()
        hl.exec_cmd("awww-daemon")
        hl.exec_cmd(${toLua "awww img '${theme.wallpaper}' --transition-type grow --transition-duration 1"})
        hl.exec_cmd("wl-paste --type text --watch cliphist store")
        hl.exec_cmd("wl-paste --type image --watch cliphist store")
        hl.exec_cmd("blueman-applet")
      end)

      ${execBind "SUPER + Return" "ghostty"}
      ${execBind "SUPER + D" "rofi -show drun"}
      ${execBind "SUPER + B" "zen"}
      ${execBind "SUPER + E" "nautilus"}
      ${execBind "SUPER + M" "alacritty"}
      ${dispatchBind "SUPER + Q" "hl.dsp.window.close()"}
      ${dispatchBind "SUPER + SHIFT + Q" "hl.dsp.exit()"}
      ${dispatchBind "SUPER + F" ''hl.dsp.window.fullscreen({ mode = "maximized" })''}
      ${dispatchBind "SUPER + SHIFT + F" ''hl.dsp.window.fullscreen({ mode = "fullscreen" })''}
      ${dispatchBind "SUPER + T" ''hl.dsp.window.float({ action = "toggle" })''}
      ${dispatchBind "SUPER + P" "hl.dsp.window.pseudo()"}
      ${execBind "SUPER + L" "hyprlock"}
      ${execBind "SUPER + SHIFT + E" "wlogout"}
      ${execBind "SUPER + SHIFT + C" "hyprpicker -a"}
      ${execBind "SUPER + SHIFT + S" ''grim -g "$(slurp)" - | swappy -f -''}
      ${execBind "SUPER + SHIFT + R" ''wf-recorder -g "$(slurp)"''}
      ${execBind "SUPER + V" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"}

      ${dispatchBind "SUPER + left" ''hl.dsp.focus({ direction = "left" })''}
      ${dispatchBind "SUPER + down" ''hl.dsp.focus({ direction = "down" })''}
      ${dispatchBind "SUPER + up" ''hl.dsp.focus({ direction = "up" })''}
      ${dispatchBind "SUPER + right" ''hl.dsp.focus({ direction = "right" })''}
      ${dispatchBind "SUPER + SHIFT + left" ''hl.dsp.window.move({ direction = "left" })''}
      ${dispatchBind "SUPER + SHIFT + down" ''hl.dsp.window.move({ direction = "down" })''}
      ${dispatchBind "SUPER + SHIFT + up" ''hl.dsp.window.move({ direction = "up" })''}
      ${dispatchBind "SUPER + SHIFT + right" ''hl.dsp.window.move({ direction = "right" })''}

      ${workspaceBinds}
      ${dispatchBind "SUPER + CTRL + left" ''hl.dsp.focus({ workspace = "-1" })''}
      ${dispatchBind "SUPER + CTRL + right" ''hl.dsp.focus({ workspace = "+1" })''}
      ${dispatchBind "SUPER + CTRL + SHIFT + left" ''hl.dsp.window.move({ workspace = "-1" })''}
      ${dispatchBind "SUPER + CTRL + SHIFT + right" ''hl.dsp.window.move({ workspace = "+1" })''}
      ${dispatchBind "SUPER + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })''}
      ${dispatchBind "SUPER + mouse_up" ''hl.dsp.focus({ workspace = "e-1" })''}
      hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

      ${repeatExecBind "XF86AudioRaiseVolume" "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"}
      ${repeatExecBind "XF86AudioLowerVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"}
      ${repeatExecBind "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"}
      ${repeatExecBind "XF86AudioMicMute" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"}
      ${repeatExecBind "XF86MonBrightnessUp" "brightnessctl set +5%"}
      ${repeatExecBind "XF86MonBrightnessDown" "brightnessctl set 5%-"}
      ${execBind "XF86AudioPlay" "playerctl play-pause"}
      ${execBind "XF86AudioNext" "playerctl next"}
      ${execBind "XF86AudioPrev" "playerctl previous"}
    '';
  };
}
