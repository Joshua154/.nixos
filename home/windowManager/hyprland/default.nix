{ config, pkgs, xdg, lib, ... }:
{
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, exec, firefox"
          ", Print, exec, grimblast copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
              let ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
  
  
    home.packages = with pkgs; [
      kitty
      waybar
      wofi
      mako
    ];

#  programs.waybar.enable = true;
#  services.gnome-keyring.enable = true;
#
#  home.sessionVariables = {
#    NIXOS_OZONE_WL = "1";
#    WLR_NO_HARDWARE_CURSORS = "1";
#  };
}
