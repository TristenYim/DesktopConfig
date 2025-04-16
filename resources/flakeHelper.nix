# These functions help make system and home flake configurations.

{ inputs, ... }:
let
    system = "x86_64-linux";
    
    # Same as specialArgs but for Home Manager
    extraSpecialArgs = {
        inputs = inputs;
    };
in
{
    mkHost = additionalModules: userConfigs: inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        
        # These are custom arguments
        specialArgs = {
            inputs = inputs; # Allows us to reference everything in inputs without having to explicitly import it
        };

        modules = additionalModules ++ [
            # Modules to be included for all hosts
            inputs.catppuccin.nixosModules.catppuccin
            inputs.impermanence.nixosModules.impermanence
            inputs.nixos-cli.nixosModules.nixos-cli

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
            inputs.catppuccin.homeManagerModules.catppuccin
            inputs.nixvim.homeManagerModules.nixvim

            # Note: Impermanence will not function in standalone mode, but still must be imported to build
            inputs.impermanence.nixosModules.home-manager.impermanence
        ];
      in
    {
        module = additionalImports: {
            imports = additionalImports ++ userImports;
        };

        standalone = additionalModules: inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs {
                inherit system;
            };
            inherit extraSpecialArgs;

            modules = additionalModules ++ userImports;
        };
    };
}
