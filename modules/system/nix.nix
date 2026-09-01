{
  lib,
  settings,
  ...
}: {
  time.timeZone = settings.localization.timeZone;

  i18n = {
    defaultLocale = settings.localization.defaultLocale;
    extraLocaleSettings = {
      LC_MEASUREMENT = settings.localization.regionalLocale;
      LC_MONETARY = settings.localization.regionalLocale;
      LC_TIME = settings.localization.regionalLocale;
    };
  };

  nix = {
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        settings.user.name
      ];
      # download-buffer-size = 536870912; # 512 MiB
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      permittedInsecurePackages = settings.permittedInsecurePackages;
    };
  };
}
