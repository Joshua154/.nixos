{
  theme,
  wallpaper,
  ...
}: let
  c = theme.colors;
in {
  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = ${wallpaper.lock}
      blur_passes = 3
      blur_size = 8
    }

    input-field {
      monitor =
      size = 320, 56
      outline_thickness = 2
      dots_size = 0.25
      outer_color = rgb(${c.accent})
      inner_color = rgb(${c.surface})
      font_color = rgb(${c.foreground})
      placeholder_text = <i>Password…</i>
      fail_color = rgb(${c.red})
      position = 0, -70
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:1000] date +"%H:%M"
      color = rgb(${c.foreground})
      font_size = 72
      position = 0, 100
      halign = center
      valign = center
    }
  '';

  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pidof hyprlock || hyprlock
      before_sleep_cmd = loginctl lock-session
      after_sleep_cmd = hyprctl dispatch dpms on
    }

    listener {
      timeout = 300
      on-timeout = loginctl lock-session
    }

    listener {
      timeout = 330
      on-timeout = hyprctl dispatch dpms off
      on-resume = hyprctl dispatch dpms on
    }

    listener {
      timeout = 1800
      on-timeout = systemctl suspend
    }
  '';
}
