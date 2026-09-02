{
  host,
  lib,
  pkgs,
  ...
}: let
  cfg = host.cloudflared or {};
in {
  environment.systemPackages = with pkgs; [
    cloudflared
  ];

  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };
  users.groups.cloudflared = {};

  systemd.services.cloudflared-tunnel = lib.mkIf (cfg.enableTunnel or false) {
    description = "Cloudflare Zero Trust Tunnel Connector";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      EnvironmentFile = cfg.credentialsFile or "/var/lib/cloudflare-token";
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token \${CLOUDFLARE_TUNNEL_TOKEN}";

      Restart = "always";
      RestartSec = "5s";
      User = "cloudflared";
      Group = "cloudflared";

      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ReadOnlyPaths = ["/"];
      ReadWritePaths = [];
      CapabilityBoundingSet = "";
    };
  };
}
