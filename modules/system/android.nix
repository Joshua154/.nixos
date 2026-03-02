{
  config,
  pkgs,
  username,
  ...
}: {
  programs.adb.enable = true;

  users.users.${username}.extraGroups = [
    "adbusers"
    "kvm"
  ];

  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
  ];
}
