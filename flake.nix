{
  description = "Larry's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Using unstable is common for Hyprland for latest features

    home-manager = {
      url = "github:nix-community/home-manager"; # Recommend tracking the main branch
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      "larry-desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # Pass inputs to modules
        modules = [
          # Main system configuration
          ./configuration.nix

          # Add Home-Manager module
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}