{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  # env vars
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Essential Hyprland tools
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    hyprsunset
    hyprpolkitagent
  ];

  # XDG Portal for Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
    };
  };

  # Enable required services
  services.dbus.enable = true;
  security.polkit.enable = true;
}
