{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./launcher.nix
    ./lock.nix
    ./notifications.nix
    ./openwallpaper.nix
    # ./waybar.nix
    ./caelestia.nix
    ./wayvnc.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    grim
    nwg-displays
    pamixer
    pavucontrol
    playerctl
    qalculate-gtk
    rofi
    slurp
    satty
    swappy
    waypaper
    wf-recorder
    wl-clipboard
    wlogout
    wireplumber
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
