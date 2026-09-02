{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./launcher.nix
    ./lock.nix
    ./notifications.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    cliphist
    grim
    hyprpicker
    pamixer
    pavucontrol
    playerctl
    rofi
    slurp
    swappy
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
