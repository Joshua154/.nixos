{lib}: let
  defaults = import ./config/default.nix;
  privatePath = ./config/private.nix;
  private =
    if builtins.pathExists privatePath
    then import privatePath
    else {};
in
  lib.recursiveUpdate defaults private
