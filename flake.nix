{
  description = "Modular multi-host NixOS configuration";

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
    nixpkgs,
    home-manager,
    lanzaboote,
    ...
  } @ inputs: let
    settings = import ./settings.nix {inherit (nixpkgs) lib;};
    inherit (settings) system;

    mkHost = hostname: let
      host = settings.hosts.${hostname};
      username = settings.user.name;
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs settings host username hostname lanzaboote;
        };
        modules = [
          ./hosts
          ./modules

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs settings host username hostname;
              };
              users.${username}.imports = [./home];
            };
          }
        ];
      };
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    devShells.${system}.benchmark = import ./benchmark/benchmark.nix {
      pkgs = nixpkgs.legacyPackages.${system};
    };

    nixosConfigurations = nixpkgs.lib.mapAttrs (hostname: _: mkHost hostname) settings.hosts;
  };
}
