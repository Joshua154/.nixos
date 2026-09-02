{
  config,
  host,
  lib,
  username,
  ...
}: let
  cfg = host.samba or {};
  homeDirectory = config.users.users.${username}.home;
  absolute = path:
    if lib.hasPrefix "/" path
    then path
    else "${homeDirectory}/${path}";
  shareSettings = lib.mapAttrs (_: share: {
    path = absolute share.path;
    "read only" = "no";
    "guest ok" =
      if share.public or false
      then "yes"
      else "no";
    browseable = "yes";
  }) (cfg.shares or {});
  directoryRule = _: share: let
    mode =
      if share.public or false
      then "0755"
      else "0750";
  in "d ${absolute share.path} ${mode} ${username} users -";
in {
  services.samba = {
    enable = true;
    openFirewall = true;
    smbd.enable = true;
    settings =
      {
        global = {
          security = "user";
          workgroup = "WORKGROUP";
          "server string" = "Samba Server";
          "map to guest" = "Bad User";
          "log file" = "/var/log/samba/log.%m";
          "max log size" = "50";
          "dns proxy" = "no";
          "invalid users" = ["root"];
        };
      }
      // shareSettings;
  };

  systemd.tmpfiles.rules = lib.mapAttrsToList directoryRule (cfg.shares or {});
}
