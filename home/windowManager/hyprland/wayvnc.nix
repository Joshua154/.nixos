{
  config,
  lib,
  pkgs,
  ...
}: let
  stateDir = "${config.xdg.stateHome}/wayvnc";
  prepare = pkgs.writeShellScript "wayvnc-prepare" ''
    set -eu
    umask 077
    mkdir -p ${lib.escapeShellArg stateDir}
    cd ${lib.escapeShellArg stateDir}
    if [ ! -s rsa_key.pem ]; then
      ${pkgs.openssl}/bin/openssl genrsa -traditional -out rsa_key.pem 2048
    fi
    if [ ! -s config ]; then
      password="$(${pkgs.openssl}/bin/openssl rand -hex 16)"
      cat > config.tmp <<EOF
    address=0.0.0.0
    port=5900
    enable_auth=true
    username=${config.home.username}
    password=$password
    rsa_private_key_file=${stateDir}/rsa_key.pem
    EOF
      mv config.tmp config
    fi
  '';
in {
  home.packages = [pkgs.wayvnc];

  # Keep credentials out of the world-readable Nix store.
  systemd.user.services.wayvnc = {
    Unit = {
      Description = "VNC access to the Hyprland session";
      After = ["hyprland-session.target"];
      PartOf = ["hyprland-session.target"];
    };
    Service = {
      ExecStartPre = toString prepare;
      ExecStart = "${lib.getExe pkgs.wayvnc} --config ${lib.escapeShellArg "${stateDir}/config"}";
      Restart = "on-failure";
      RestartSec = 3;
      UMask = "0077";
    };
    Install.WantedBy = ["hyprland-session.target"];
  };
}
