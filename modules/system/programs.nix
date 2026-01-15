{pkgs, ...}: {
  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };

    steam.enable = true;

    dconf.enable = true;
    adb.enable = true;
    zsh.enable = true;

    noisetorch.enable = true;

    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
      ];
    };
  };
}
