{theme, ...}: let
  c = theme.colors;
in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        origin = "top-right";
        offset = "(14, 66)";
        width = 380;
        height = "(0, 180)";
        notification_limit = 5;
        gap_size = 8;
        padding = 14;
        horizontal_padding = 16;
        text_icon_padding = 14;
        frame_width = 1;
        frame_color = "#${c.overlay}";
        separator_height = 0;
        separator_color = "#${c.overlay}";
        corner_radius = 16;
        icon_corner_radius = 10;
        background = "#${c.background}f2";
        foreground = "#${c.foreground}";
        highlight = "#${c.accent}";
        font = "Noto Sans 10";
        format = "<span size='small' foreground='#${c.muted}'>%a</span>\\n<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        ellipsize = "end";
        word_wrap = true;
        show_indicators = false;
        min_icon_size = 40;
        max_icon_size = 52;
        progress_bar = true;
        progress_bar_height = 6;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 180;
        progress_bar_max_width = 348;
        progress_bar_corner_radius = 3;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_current";
        mouse_right_click = "close_all";
      };
      urgency_low = {
        timeout = 3;
        frame_color = "#${c.overlay}";
      };
      urgency_normal = {
        timeout = 7;
        frame_color = "#${c.accent}";
      };
      urgency_critical = {
        timeout = 0;
        frame_color = "#${c.red}";
      };

      quick-settings = {
        appname = "Quick settings";
        timeout = 2;
        history_ignore = true;
        frame_color = "#${c.overlay}";
      };
    };
  };
}
