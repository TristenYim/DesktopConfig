{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        # nixpkgs24-05.url = "github:nixos/nixpkgs/nixos-24.05";
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
            # url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=918d8340afd652b011b937d29d5eea0be08467f5";
            url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
            # inputs.nixpkgs.follows = "nixpkgs24-05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hycov = {
            url = "github:DreamMaoMao/hycov";
            # inputs.nixpkgs.follows = "nixpkgs24-05";
            inputs.hyprland.follows = "hyprland";
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

    outputs = { nixpkgs, catppuccin, firefox-addons, impermanence, home-manager, hyprland, hycov, nixvim, nixgl, ... }@inputs:
      let 
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nixgl.overlay ];
        };
        # pkgs24-05 = import nixpkgs24-05 {
        #     system = "x86_64-linux";
        # };
      in {
	    nixosConfigurations.unfathomable-main = nixpkgs.lib.nixosSystem {
            inherit system;
            # specialArgs = {
            #     inherit pkgs24-05;
            # };
            modules = [
                ./hosts/unfathomable-main/configuration.nix
                catppuccin.nixosModules.catppuccin
                impermanence.nixosModules.impermanence

                # Import Home Manager profiles
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;

                        # These are custom arguments
                        extraSpecialArgs = { 
                            inherit inputs; # Allows us to reference everything in inputs without having to explicitly import it
                            # inherit pkgs24-05;
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
