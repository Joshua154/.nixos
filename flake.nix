{
  description = "Joshua's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    lanzaboote,
    ...
  } @ inputs: let
    settings = import ./settings.nix;
    inherit (settings) system;

    mkHost = hostname: let
      host = settings.hosts.${hostname};
      username = settings.user.name;
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs settings host username hostname system lanzaboote;
        };
        modules = [
          ./hosts/${hostname}
          ./modules

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs settings host username hostname system;
              };
              users.${username}.imports = [./home];
            };
          }
        ];
      };
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations = nixpkgs.lib.genAttrs (builtins.attrNames settings.hosts) mkHost;

    checks.${system} = builtins.mapAttrs (_: host: host.config.system.build.toplevel) self.nixosConfigurations;
  };
}
