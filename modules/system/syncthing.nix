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
          "obsidian-vault_Studium" = {
            path = "/home/${username}/Documents/Studium/26_SoSe";
            devices = [ "ipad" ];
          };
        };
        devices = {
          "ipad" = { id = "JAHWFNY"; };
        };
      };
    };
}