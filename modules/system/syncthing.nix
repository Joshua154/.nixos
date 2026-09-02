{
  config,
  host,
  lib,
  username,
  ...
}: let
  cfg = host.syncthing or {};
  homeDirectory = config.users.users.${username}.home;
  absolute = path:
    if lib.hasPrefix "/" path
    then path
    else "${homeDirectory}/${path}";
  folders = lib.mapAttrs (_: folder: folder // {path = absolute folder.path;}) (cfg.folders or {});
in {
  services.syncthing = {
    enable = true;
    user = username;
    dataDir = absolute (cfg.dataDirectory or "Sync");
    configDir = "${homeDirectory}/.config/syncthing";

    openDefaultPorts = true;

    settings = {
      inherit folders;
      devices = cfg.devices or {};
    };
  };
}
