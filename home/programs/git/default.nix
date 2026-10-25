{settings, ...}: {
  programs.git = {
    enable = true;
    
    settings = {
      user = {
        inherit (settings.user) email;
        name = settings.user.fullName;
      };

      push.recurseSubmodules = "on-demand";

      status.submoduleSummary = true;

      diff.submodule = "log";

      submodule.recurse = true;
    };

    lfs.enable = true;
  };
}