{
    description = "Nixos config flake";

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

            sklodowska-curie = flakeHelper.mkHost ./hosts/sklodowska-curie/configuration.nix {
                fathom = flakeHelper.mkUser.module ./users/fathom-sklodowska-curie.nix;
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
    
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11-small";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        impermanence.url = "github:nix-community/impermanence";
        catppuccin = {
            url = "github:catppuccin/nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
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
            ref = "refs/tags/v0.48.1";
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
            rev = "5b62529c2011ede6069445de9b5b3f8a1f10ecfe"; # Pinning version until I update Hyprland
            inputs.hyprland.follows = "hyprland";
        };
        hyprsplit = {
            # Numbers workspaces per-monitor instead of globally
            type = "git";
            url = "https://github.com/shezdy/hyprsplit";
            ref = "refs/tags/v0.48.1";
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
}
