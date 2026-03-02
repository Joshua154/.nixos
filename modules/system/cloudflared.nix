{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cloudflared
    # cloudflare-warp
  ];

  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };
  users.groups.cloudflared = {};

  systemd.services.cloudflared-tunnel = {
    description = "Cloudflare Zero Trust Tunnel Connector";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      EnvironmentFile = "/var/lib/cloudflare-token";
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

  # services.cloudflare-warp.enable = true;
}
