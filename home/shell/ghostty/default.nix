{theme, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      background = theme.colors.background;
      foreground = theme.colors.foreground;
      cursor-color = theme.colors.accent;
      selection-background = theme.colors.overlay;
      selection-foreground = theme.colors.foreground;
      palette = [
        "0=#${theme.colors.background}"
        "1=#${theme.colors.red}"
        "2=#${theme.colors.green}"
        "3=#${theme.colors.yellow}"
        "4=#${theme.colors.accent}"
        "5=#${theme.colors.secondary}"
        "6=#${theme.colors.secondary}"
        "7=#${theme.colors.foreground}"
      ];
      font-size = 14;
      background-blur-radius = 20;
      mouse-hide-while-typing = true;
      window-decoration = true;
      # keybind = global:cmd+/=toggle_quick_terminal;
      macos-option-as-alt = true;
      # background-opacity = 0.7;
      # background-blur-radius = 20;
    };
    #enableZshIntegration = true;
  };
}
