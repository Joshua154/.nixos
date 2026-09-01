{
  pkgs,
  settings,
  ...
}: let
  inherit (settings.user) name fullName;
in {
  users = {
    defaultUserShell = pkgs.zsh;

    users.${name} = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = fullName;
      extraGroups = [
        "adbusers"
        "audio"
        "dialout"
        "docker"
        "kvm"
        "libvirtd"
        "networkmanager"
        "video"
        "wheel"
        "input"
      ];
    };

    extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];
  };
}
