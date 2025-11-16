{
  description = "My modular NixOS configuration with multiple hosts and Home-Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    username = "joshua";
    version = "25.05";

    mkNixOSHost = { hostName, system, specialArgs, modules }:
      nixpkgs.lib.nixosSystem {
        inherit system;

        inherit specialArgs;

        modules = [
          ./hosts/${hostName}/hardware-configuration.nix

          home-manager.nixosModules.home-manager

          ./hosts/common.nix

          ./hosts/${hostName}/default.nix
        ] ++ modules;
      };
    
    specialArgs = {
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      inherit inputs;
      inherit username version;
    };

  in
  {
    nixosConfigurations.JNix-Desktop = mkNixOSHost {
      hostName = "JNix-Desktop";
      inherit system specialArgs;
      modules = [];
    };

    nixosConfigurations.JNix-Laptop = mkNixOSHost {
      hostName = "JNix-Laptop";
      inherit system specialArgs;
      modules = [
        ./modules/nixos/power-management.nix
      ];
    };
  };
}