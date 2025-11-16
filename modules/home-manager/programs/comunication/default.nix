{ pkgs, config, ... }:
{
  imports = [
    ./vencord.nix
  ];

  home.packages = with pkgs; [
		teams-for-linux
    beeper
    # bluemail
  ];
}
