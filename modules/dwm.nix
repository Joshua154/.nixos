{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.enable = true;
  #services.xserver.displayManager.lightdm.enable = true;

  environment.systemPackages = with pkgs; [
    dwm
    dmenu
    st
    alacritty
  ];
}
