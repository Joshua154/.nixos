{
  inputs,
  pkgs,
  ...
}: {
  programs.caelestia.package =
    inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli.overrideAttrs
      (old: {
        patches = (old.patches or []) ++ [
          ./my-additions.patch
        ];
      });
}
