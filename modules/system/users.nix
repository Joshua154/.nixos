{
  pkgs,
  username,
  ...
}: {
  users = {
    defaultUserShell = pkgs.zsh;

    users.${username} = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = username;
      extraGroups = [
        "adbusers"
        "audio"
        "dialout"
        "docker"
        "networkmanager"
        "video"
        "wheel"
      ];
    };

    extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];
  };
}
