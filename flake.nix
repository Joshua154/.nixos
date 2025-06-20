{
  description = "Joshua's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }@inputs:
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

	  home-manager.nixosModules.home-manager {
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

      

      #homeConfigurations = {
#	"${username}" = home-manager.lib.homeManagerConfiguration {
#	  inherit pkgs;
#	  modules = [ ./home/home.nix ];
#        };
#      };	
    };
}
