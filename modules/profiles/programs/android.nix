{
  pkgs,
  username,
  ...
}: {
  users.users.${username}.extraGroups = ["adbusers" "kvm"];

  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
  ];
}
