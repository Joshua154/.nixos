{
  pkgs,
  inputs,
  lib,
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

  # VNC is reachable through Tailscale and private IPv4 LANs only.
  networking.firewall = let
    lanRanges = ["10.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16"];
    rules = action:
      lib.concatMapStringsSep "\n" (
        range: "iptables ${action} nixos-fw -s ${range} -p tcp --dport 5900 -j nixos-fw-accept"
      )
      lanRanges;
  in {
    interfaces.tailscale0.allowedTCPPorts = [5900];
    extraCommands = rules "-A";
    extraStopCommands = rules "-D";
  };
}
