{ pkgs, lib, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
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
