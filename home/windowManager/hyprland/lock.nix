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
      blur_passes = 2
      blur_size = 7
      brightness = 0.72
      vibrancy = 0.18
      vibrancy_darkness = 0.12
    }

    input-field {
      monitor =
      size = 340, 58
      outline_thickness = 1
      rounding = 18
      dots_size = 0.22
      dots_spacing = 0.28
      dots_center = true
      outer_color = rgb(${c.accent})
      inner_color = rgba(${c.surface}e8)
      font_color = rgb(${c.foreground})
      check_color = rgb(${c.green})
      fail_color = rgb(${c.red})
      capslock_color = rgb(${c.yellow})
      placeholder_text = <span foreground="##${c.muted}">Password…</span>
      fail_text = <span foreground="##${c.red}">$FAIL <b>($ATTEMPTS)</b></span>
      fade_on_empty = false
      shadow_passes = 3
      shadow_size = 8
      shadow_color = rgba(${c.background}99)
      position = 0, -95
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:1000] date +"%H:%M"
      color = rgb(${c.foreground})
      font_family = Noto Sans
      font_size = 86
      shadow_passes = 3
      shadow_size = 7
      shadow_color = rgba(${c.background}aa)
      position = 0, 125
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:60000] date +"%A, %d %B"
      color = rgb(${c.secondary})
      font_family = Noto Sans
      font_size = 17
      shadow_passes = 2
      shadow_size = 5
      shadow_color = rgba(${c.background}aa)
      position = 0, 62
      halign = center
      valign = center
    }

    label {
      monitor =
      text =   $USER
      color = rgb(${c.muted})
      font_family = JetBrainsMono Nerd Font
      font_size = 13
      position = 0, -155
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
