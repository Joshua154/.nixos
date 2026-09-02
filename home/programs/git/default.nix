{settings, ...}: {
  programs.git = {
    enable = true;
    settings.user = {
      inherit (settings.user) email;
      name = settings.user.fullName;
    };

    lfs.enable = true;
  };
}
