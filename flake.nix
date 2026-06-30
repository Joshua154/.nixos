{
  description = "Joshua's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
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
    system = "x86_64-linux";

    mkHost = hostname: username: modules:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs username hostname system lanzaboote;
        };
        modules =
          [
            ./hosts/${hostname}

            {
              nixpkgs.config.permittedInsecurePackages = [
                "electron-39.8.10"
              ];
            }

            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs username hostname system;
                };
                users."${username}" = {
                  imports = [
                    ./home
                  ];
                };
              };
            }
          ]
          ++ modules;
      };
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    # Define your hosts here
    nixosConfigurations = {
      laptop = mkHost "laptop" "joshua" [];
      desktop = mkHost "desktop" "joshua" [];
    };
  };
}
