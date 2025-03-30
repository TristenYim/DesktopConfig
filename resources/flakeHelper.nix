# These functions help make system and home flake configurations.

{ nixpkgs, home-manager, catppuccin, impermanence, nixos-cli, nixvim, inputs, ... }:
let
    system = "x86_64-linux";
    
    # Same as specialArgs but for Home Manager
    extraSpecialArgs = {
        inputs = inputs;
    };
in
{
    mkHost = additionalModules: userConfigs: nixpkgs.lib.nixosSystem {
        inherit system;
        
        # These are custom arguments
        specialArgs = {
            inputs = inputs; # Allows us to reference everything in inputs without having to explicitly import it
        };

        modules = additionalModules ++ [
            # Modules to be included for all hosts
            catppuccin.nixosModules.catppuccin
            impermanence.nixosModules.impermanence
            nixos-cli.nixosModules.nixos-cli

            # Include Home Manager configurations
            home-manager.nixosModules.home-manager {
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
            catppuccin.homeManagerModules.catppuccin
            nixvim.homeManagerModules.nixvim

            # Note: Impermanence will not function in standalone mode, but still must be imported to build
            impermanence.nixosModules.home-manager.impermanence
        ];
      in
    {
        module = additionalImports: {
            imports = additionalImports ++ userImports;
        };

        standalone = additionalModules: home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
                inherit system;
            };
            inherit extraSpecialArgs;

            modules = additionalModules ++ userImports;
        };
    };
}
