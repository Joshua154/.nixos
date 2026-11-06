{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./lock.nix
    ./openwallpaper.nix
    # ./waybar.nix
    ./caelestia.nix
    ./wayvnc.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    fuzzel # dmenu for `caelestia clipboard` / `caelestia emoji`
    nwg-displays
    pamixer
    pavucontrol
    playerctl
    qalculate-gtk
    waypaper
    wl-clipboard
    wlogout
    wireplumber
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
