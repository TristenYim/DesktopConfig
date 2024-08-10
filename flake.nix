{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        catppuccin.url = "github:catppuccin/nix";
        firefox-addons = {
            url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland = {
            url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixgl = {
            url = "github:guibou/nixGL";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, catppuccin, firefox-addons, home-manager, hyprland, nixvim, nixgl, ... }@inputs:
      let 
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nixgl.overlay ];
        };
      in {
        nixosConfigurations.test-surface = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
                ./hosts/test-surface/configuration.nix
                catppuccin.nixosModules.catppuccin
            ];
        };

        homeConfigurations."fathom@test-surface" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Thanks a lot VimJoyer for making this tutorial
            # using this god-awful syntax that doesn't tell
            # you anything about what this option does.

            # Seriously, what does "extraSpecialArgs" mean?
            extraSpecialArgs = { inherit inputs; };

            modules = [ 
                ./home-manager/accounts/fathom-test-surface.nix 
                catppuccin.homeManagerModules.catppuccin
                hyprland.homeManagerModules.default
                nixvim.homeManagerModules.nixvim
            ];
        };

        homeConfigurations.fathom = home-manager.lib.homeManagerConfiguration {
          # pkgs = nixpkgs.legacyPackages.${system};
            inherit pkgs;
            modules = [ 
                ./home-manager/accounts/fathom-default.nix 
                catppuccin.homeManagerModules.catppuccin
                hyprland.homeManagerModules.default
                nixvim.homeManagerModules.nixvim
            ];
        };

        homeConfigurations.tdoggy = home-manager.lib.homeManagerConfiguration {
          # pkgs = nixpkgs.legacyPackages.${system};
            inherit pkgs;
            modules = [ 
                ./home-manager/accounts/tdoggy-default.nix
                catppuccin.homeManagerModules.catppuccin
                nixvim.homeManagerModules.nixvim
            ];
        };
    };
}
