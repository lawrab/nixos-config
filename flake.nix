{
  description = "Larry's NixOS Configuration";
  
  nixConfig = {
    extra-substituters = [
      "https://cuda-maintainers.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05"; 
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: 
    let
      theme = import ./theme/theme.nix;
      system = "x86_64-linux";
      
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
  {
    nixosConfigurations = {
      "larry-desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs pkgs-unstable theme; }; # Pass inputs to modules
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