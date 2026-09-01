{...}: {
  # Keep machine-generated hardware facts separate from selectable profiles.
  imports = [./hardware-configuration.nix];
}
