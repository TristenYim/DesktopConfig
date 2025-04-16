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

    outputs = { ... } @ inputs:
      let 
        flakeHelper = import ./resources/flakeHelper.nix { inherit inputs; };
      in 
    {
	    nixosConfigurations = {
            unfathomable-main = flakeHelper.mkHost ./hosts/unfathomable-main/configuration.nix {
                fathom = flakeHelper.mkUser.module ./users/fathom-unfathomable-main.nix;
                tdoggy = flakeHelper.mkUser.module ./users/tdoggy-unfathomable-main.nix;
            };

            # Portable ISO configuration
            shallow-ISO = flakeHelper.mkHost ./hosts/shallow-ISO/configuration.nix {
                nixos = flakeHelper.mkUser.module ./users/nixos-shallow-ISO.nix;
            };
        };

        homeConfigurations = {
            # Machine-specific standalone configurations
            "fathom@tumbling-school" = flakeHelper.mkUser.standalone ./users/fathom-tumbling-school.nix;

            # Default user configurations
            fathom = flakeHelper.mkUser.standalone ./users/fathom-default.nix;
            tdoggy = flakeHelper.mkUser.standalone ./users/tdoggy-default.nix;
        };
    };
}
