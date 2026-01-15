{
  pkgs,
  username,
  ...
}: {
  users = {
    defaultUserShell = pkgs.zsh;

    users.${username} = {
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
