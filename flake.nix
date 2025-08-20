{
  description = "Joshua's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    
    omarchy-nix = {
      url = "github:henrysipp/omarchy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, flake-utils, omarchy-nix, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      hostname = "JNix";
      username = "joshua";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs username hostname system;
        };
        modules = [
          ./hosts/JNix

          omarchy-nix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            omarchy = {
              full_name = "Your Name";
              email_address = "your.email@example.com";
              theme = "tokyo-night";
            };
          
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users."${username}" = {
                imports = [
                  ./home
                  omarchy-nix.homeManagerModules.default
                ];
              };
            };
          }
        ];
      };
    };
}
