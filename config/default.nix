{
  system = "x86_64-linux";
  stateVersion = "25.05";
  theme = "balcony";

  # Neutral values keep the public flake evaluable without exposing identity.
  user = {
    name = "nixos";
    fullName = "NixOS User";
    email = "nixos@example.invalid";
  };

  localization = {
    timeZone = "UTC";
    defaultLocale = "en_US.UTF-8";
    regionalLocale = "en_US.UTF-8";
  };

  permittedInsecurePackages = [
    "electron-39.8.10"
    "openssl-1.1.1w"
    "xpdf-4.05"
  ];

  # Hosts are intentionally private. Copy private.example.nix to private.nix.
  hosts = {};
}
