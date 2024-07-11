{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        catppuccin.url = "github:catppuccin/nix";
        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixgl = {
            url = "github:guibou/nixGL";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, hyprland, catppuccin, nixgl, ... }@inputs:
      let 
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nixgl.overlay ];
        };
      in {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
                ./hosts/unfathomable-surface/configuration.nix
                catppuccin.nixosModules.catppuccin
            ];
        };

        homeConfigurations.fathom = home-manager.lib.homeManagerConfiguration {
          # pkgs = nixpkgs.legacyPackages.${system};
            inherit pkgs;
            modules = [ 
                ./home-manager/fathom/home.nix 
                catppuccin.homeManagerModules.catppuccin
                hyprland.homeManagerModules.default
            ];
        };

        homeConfigurations.tdoggy = home-manager.lib.homeManagerConfiguration {
          # pkgs = nixpkgs.legacyPackages.${system};
            inherit pkgs;
            modules = [ 
                ./home-manager/tdoggy/home.nix
                catppuccin.homeManagerModules.catppuccin
            ];
        };
    };
}
