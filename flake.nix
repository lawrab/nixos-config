{
  description = "Larry's NixOS Configuration";
  
  # Binary cache configuration for CUDA packages
  nixConfig = {
    extra-substituters = [
      "https://cuda-maintainers.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  inputs = {
    # Stable release branch for reliable system packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05"; 
    # Unstable branch for latest packages (Firefox, development tools, etc.)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Use same nixpkgs version for consistency
    };

    # Catppuccin theming for comprehensive application support
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, catppuccin, ... }@inputs: 
    let
      theme = import ./theme/theme.nix;
      system = "x86_64-linux";
      
      # Import unstable packages with unfree software enabled
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true; # Allow proprietary software like Steam, Discord, etc.
      };
    in
  {
    nixosConfigurations = {
      "larry-desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs pkgs-unstable theme catppuccin; }; # Pass variables to all modules
        modules = [
          ./configuration.nix # System-level configuration
          home-manager.nixosModules.home-manager # User environment management
          catppuccin.nixosModules.catppuccin # Catppuccin theming support
        ];
      };
    };
  };
}