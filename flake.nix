{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        catppuccin.url = "github:catppuccin/nix";
        impermanence.url = "github:nix-community/impermanence";
        firefox-addons = {
            url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland = {
            type = "git";
            url = "https://github.com/hyprwm/Hyprland";
            ref = "refs/tags/v0.48.0";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hycov = {
            url = "github:bighu630/hycov"; # Using a fork which actually builds with Nix
            inputs.hyprland.follows = "hyprland";
        };
        hyprspace = {
            # Experimenting with using Hyprspace alongside or as a replacement to hycov
            type = "git";
            url = "https://github.com/KZDKM/Hyprspace";
            inputs.hyprland.follows = "hyprland";
        };
        hyprsplit = {
            # Numbers workspaces per-monitor instead of globally
            type = "git";
            url = "https://github.com/shezdy/hyprsplit";
            ref = "refs/tags/v0.48.0";
            inputs.hyprland.follows = "hyprland";
        };
        nixgl = {
            url = "github:johanneshorner/nixGL";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-cli = {
            url = "github:water-sucks/nixos";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, catppuccin, impermanence, home-manager, hyprland, nixvim, nixos-cli, nixgl, ... }@inputs:
      let 
        pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nixgl.overlay ];
        };
        flakeHelper = import ./resources/flakeHelper.nix { inherit nixpkgs catppuccin impermanence home-manager nixvim nixos-cli inputs; };
      in {
	    nixosConfigurations = {
            unfathomable-main = flakeHelper.mkHost [ ./hosts/unfathomable-main/configuration.nix ] {
                fathom = flakeHelper.mkUserModule [
                    ./users/fathom-unfathomable-main.nix
                    hyprland.homeManagerModules.default
                ];
                tdoggy = flakeHelper.mkUserModule [ 
                    ./users/tdoggy-unfathomable-main.nix 
                ];
            };

            shallow-ISO = flakeHelper.mkHost [ ./hosts/shallow-ISO/configuration.nix ] {
                nixos = flakeHelper.mkUserModule [
                    ./users/nixos-shallow-ISO.nix
                    hyprland.homeManagerModules.default
                ];
            };
        };

        homeConfigurations."fathom@tumbling-school" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs; };
            modules = [ 
                ./users/fathom-tumbling-school.nix 
                catppuccin.homeManagerModules.catppuccin
                hyprland.homeManagerModules.default
                nixvim.homeManagerModules.nixvim
                impermanence.nixosModules.home-manager.impermanence # Note: Impermanence will not function
            ];
        };

        homeConfigurations.fathom = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ 
                ./users/fathom-default.nix 
                catppuccin.homeManagerModules.catppuccin
                hyprland.homeManagerModules.default
                nixvim.homeManagerModules.nixvim
            ];
        };

        homeConfigurations.tdoggy = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ 
                ./users/tdoggy-default.nix
                catppuccin.homeManagerModules.catppuccin
                nixvim.homeManagerModules.nixvim
            ];
        };
    };
}
