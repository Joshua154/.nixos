{
  config,
  pkgs,
  username,
  ...
}: {
  services.syncthing = {
    enable = true;
    user = username;
    dataDir = "/home/${username}/synctrain";
    configDir = "/home/${username}/.config/syncthing";

    openDefaultPorts = true;

    settings = {
      folders = {
        "Studium" = {
          path = "/home/${username}/Documents/Studium";
          devices = ["ipad"];
        };
      };
      devices = {
        "ipad" = {id = "4KIL5M2-K43IMIU-5GVF5W5-CJRRL2A-WKKKRVI-57J4LX7-PQJYCW6-UFDMAQZ";};
      };
    };
  };
}
