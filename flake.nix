{
  description = "Joshua's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    pandora-src.url = "github:Ind-E/nixpkgs/init-PandoraLauncher";

    # winboat = {
    #   url = "github:TibixDev/winboat";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    hostname = "JNix";
    username = "joshua";
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs username hostname system;
      };
      modules = [
        ./hosts/JNix

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
      ];
    };
  };
}
