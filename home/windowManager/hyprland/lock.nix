{
  theme,
  wallpaper,
  ...
}: let
  c = theme.colors;
in {
  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
      hide_cursor = true
    }

    animations {
      enabled = true
      bezier = easeOut, 0.16, 1, 0.3, 1
      animation = fadeIn, 1, 4, easeOut
      animation = fadeOut, 1, 3, easeOut
      animation = inputFieldDots, 1, 2, easeOut
    }

    background {
      monitor =
      path = ${wallpaper.lock}
      blur_passes = 3
      blur_size = 6
      brightness = 0.58
      contrast = 1.04
      vibrancy = 0.16
      vibrancy_darkness = 0.10
    }

    shape {
      monitor =
      size = 520, 440
      color = rgba(${c.surface}b8)
      rounding = 30
      border_size = 1
      border_color = rgba(${c.accent}55)
      shadow_passes = 4
      shadow_size = 16
      shadow_color = rgba(${c.background}bb)
      position = 0, 0
      halign = center
      valign = center
    }

    input-field {
      monitor =
      size = 400, 56
      outline_thickness = 2
      rounding = 16
      dots_size = 0.22
      dots_spacing = 0.30
      dots_center = true
      outer_color = rgba(${c.accent}cc) rgba(${c.secondary}cc) 45deg
      inner_color = rgba(${c.background}d9)
      font_color = rgb(${c.foreground})
      check_color = rgb(${c.green})
      fail_color = rgb(${c.red})
      capslock_color = rgb(${c.yellow})
      font_family = Noto Sans
      placeholder_text = <span foreground="##${c.muted}">Enter your password</span>
      check_text = <span foreground="##${c.green}">Verifying…</span>
      fail_text = <span foreground="##${c.red}">$FAIL <b>($ATTEMPTS)</b></span>
      fade_on_empty = false
      shadow_passes = 3
      shadow_size = 8
      shadow_color = rgba(${c.background}99)
      position = 0, -104
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:1000] date +"%H:%M"
      color = rgb(${c.foreground})
      font_family = Noto Sans
      font_size = 78
      shadow_passes = 3
      shadow_size = 7
      shadow_color = rgba(${c.background}aa)
      position = 0, 84
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:60000] date +"%A, %d %B"
      color = rgb(${c.secondary})
      font_family = Noto Sans
      font_size = 16
      shadow_passes = 2
      shadow_size = 5
      shadow_color = rgba(${c.background}aa)
      position = 0, 22
      halign = center
      valign = center
    }

    shape {
      monitor =
      size = 400, 1
      color = rgba(${c.overlay}cc)
      rounding = -1
      position = 0, -18
      halign = center
      valign = center
    }

    label {
      monitor =
      text =   $USER
      color = rgb(${c.foreground})
      font_family = JetBrainsMono Nerd Font
      font_size = 14
      position = 0, -52
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
