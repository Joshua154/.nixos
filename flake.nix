{
  description = "Joshua's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    nixpkgs-pandora.url = "github:NixOS/nixpkgs/pull/510425/head";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixpkgs-pandora,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    mkHost = hostname: username: modules:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs username hostname system nixpkgs-pandora;
        };
        modules =
          [
            ./hosts/${hostname}

            # Pandora Launcher
            {
              environment.systemPackages = [
                nixpkgs-pandora.legacyPackages.x86_64-linux.pandora-launcher
              ];
            }

            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
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
      JNix = mkHost "JNix" "joshua" [];

      laptop = mkHost "laptop" "joshua" [];
      desktop = mkHost "desktop" "joshua" [];
    };
  };
}
