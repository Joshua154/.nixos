{
  pkgs,
  username,
  ...
}: {
  services = {
    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;

    blueman.enable = true;
    udev.packages = [pkgs.via];
    flatpak.enable = true;
    # displaylink.enable = true;

    libinput = {
      enable = true;

      touchpad = {
        tapping = true;
        middleEmulation = true;
      };
    };

    samba = {
      enable = true;
      openFirewall = true;

      smbd.enable = true;

      settings = {
        global = {
          security = "user";
          "workgroup" = "WORKGROUP";
          "server string" = "Samba Server";
          "map to guest" = "Bad User";
          "log file" = "/var/log/samba/log.%m";
          "max log size" = "50";
          "dns proxy" = "no";
          "invalid users" = ["root"];
        };

        "privateShare" = {
          path = "/home/${username}/privateShare";
          "read only" = "no";
          "guest ok" = "no";
          "browseable" = "yes";
        };

        "Public" = {
          path = "/home/${username}/Public";
          "read only" = "no";
          "guest ok" = "yes";
          "browseable" = "yes";
        };
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/${username}/Public 0755 ${username} users -"
    "d /home/${username}/privateShare 0777 ${username} users -"
  ];
}
