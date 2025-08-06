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
        betterfox = {
            url = "github:HeitorAugustoLN/betterfox-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
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
        mango = {
            type = "git";
            url = "https://github.com/DreamMaoMao/mango";
            ref = "refs/tags/0.8.0";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixgl = {
            url = "github:johanneshorner/nixGL";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        optnix = {
            url = "github:water-sucks/optnix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
}
