{theme, ...}: let
  c = theme.colors;
in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        origin = "top-right";
        offset = "12x52";
        width = 360;
        height = 140;
        padding = 14;
        horizontal_padding = 14;
        frame_width = 2;
        frame_color = "#${c.accent}";
        separator_color = "frame";
        corner_radius = 12;
        background = "#${c.background}";
        foreground = "#${c.foreground}";
        font = "JetBrainsMono Nerd Font 10";
      };
      urgency_low.timeout = 4;
      urgency_normal.timeout = 7;
      urgency_critical = {
        timeout = 0;
        frame_color = "#${c.red}";
      };
    };
  };
}
