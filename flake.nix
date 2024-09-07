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
            url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=918d8340afd652b011b937d29d5eea0be08467f5"; # Downgrading version to 0.41.2 for hycov
            # url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hycov = {
            url = "github:DreamMaoMao/hycov";
            inputs.hyprland.follows = "hyprland";
        };
        # hyprland-plugins = {
        #     url = "github:hyprwm/hyprland-plugins";
        #     inputs.hyprland.follows = "hyprland";
        # };
        # hyprspace = {
        #     url = "github:KZDKM/Hyprspace";
        #     inputs.hyprland.follows = "hyprland";
        # };
        nixgl = {
            url = "github:guibou/nixGL";
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

    outputs = { nixpkgs, catppuccin, firefox-addons, impermanence, home-manager, hyprland, nixvim, nixos-cli, nixgl, ... }@inputs:
      let 
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nixgl.overlay ];
        };
      in {
	    nixosConfigurations.unfathomable-main = nixpkgs.lib.nixosSystem {
            inherit system;
            
            # These are custom arguments
            specialArgs = {
                inherit inputs; # Allows us to reference everything in inputs without having to explicitly import it
            };
            modules = [
                ./hosts/unfathomable-main/configuration.nix
                catppuccin.nixosModules.catppuccin
                impermanence.nixosModules.impermanence
                nixos-cli.nixosModules.nixos-cli

                # Import Home Manager profiles
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;

                        # Same as specialArgs but for Home Manager
                        extraSpecialArgs = { 
                            inherit inputs;
                        };
                        users.fathom = {
                            imports = [
                                ./users/fathom-unfathomable-main.nix
                                catppuccin.homeManagerModules.catppuccin
                                hyprland.homeManagerModules.default
                                nixvim.homeManagerModules.nixvim
                                impermanence.nixosModules.home-manager.impermanence
                            ];
                        };
                    };
                }
            ];
        };

        nixosConfigurations.test-surface = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
                ./hosts/test-surface/configuration.nix
                catppuccin.nixosModules.catppuccin
            ];
        };

        homeConfigurations."fathom@test-surface" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs; };
            modules = [ 
                ./users/fathom-test-surface.nix 
                catppuccin.homeManagerModules.catppuccin
                hyprland.homeManagerModules.default
                nixvim.homeManagerModules.nixvim
            ];
        };

        homeConfigurations."fathom@tumbling-school" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs; };
            modules = [ 
                ./users/fathom-tumbling-school.nix 
                catppuccin.homeManagerModules.catppuccin
                hyprland.homeManagerModules.default
                nixvim.homeManagerModules.nixvim
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
        devShells.x86_64-linux.wine-builder = (import ./shells/wine-builder.nix { inherit pkgs; }); 
    };
}
