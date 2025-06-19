# These functions help make system and home flake configurations.

{ inputs, ... }:
let
    system = "x86_64-linux";

    # Custom library of functions used in this flake
    myLib = import ./myLib.nix { lib = inputs.nixpkgs.lib; };

    pkgs-stable = import inputs.nixpkgs-stable {
        system = "x86_64-linux";
    };

    # Same as specialArgs but for Home Manager
    extraSpecialArgs = {
        firefox-addons = inputs.firefox-addons;
        nixgl = inputs.nixgl;
        optnix = inputs.optnix;
        inherit myLib pkgs-stable;
    };
in
{
    mkHost = configuration: userConfigs: inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        
        # These are custom arguments

        # Note that inputs is not being passed directly because I prefer for 
        # each module to explicitly state its dependencies, rather than take
        # the entirety of inputs as an argument.
        specialArgs = {
            nixos-hardware = inputs.nixos-hardware;
            inherit myLib pkgs-stable;
        };

        modules = [ configuration ] ++ [
            # Modules to be included for all hosts
            inputs.catppuccin.nixosModules.catppuccin
            inputs.impermanence.nixosModules.impermanence

            # Include Home Manager configurations
            inputs.home-manager.nixosModules.home-manager {
                home-manager = {
                    inherit extraSpecialArgs;

                    useGlobalPkgs = true;

                    users = userConfigs;
                };
            }
        ];
    };

    mkUser =
      let
        # Modules to be imported for all users
        userImports = [
            inputs.catppuccin.homeModules.catppuccin
            inputs.nixvim.homeManagerModules.nixvim

            # Note: Impermanence will not function in standalone mode, but still must be imported to build
            inputs.impermanence.nixosModules.home-manager.impermanence
        ];
      in
    {
        module = configuration: {
            imports = [ configuration ] ++ userImports;
        };

        standalone = configuration: inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs {
                inherit system;
            };
            inherit extraSpecialArgs;

            modules = [ configuration ] ++ userImports;
        };
    };
}
