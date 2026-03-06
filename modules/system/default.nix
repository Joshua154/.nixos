{
  # This module is for backwards compatibility
  # Use modules/system/shared.nix for new configurations
  imports = [
    ./shared.nix
    ../profiles/display-managers/gdm.nix
  ];
}
