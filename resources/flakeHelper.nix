# These functions help make system and home flake configurations.

{ nixpkgs, home-manager, catppuccin, impermanence, nixos-cli, nixvim, inputs, ... }: rec

{
    mkHost = additionalModules: userConfigs: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        
        # These are custom arguments
        specialArgs = {
            inputs = inputs; # Allows us to reference everything in inputs without having to explicitly import it
        };

        modules = additionalModules ++ [
            catppuccin.nixosModules.catppuccin
            impermanence.nixosModules.impermanence
            nixos-cli.nixosModules.nixos-cli

            # Import Home Manager profiles
            home-manager.nixosModules.home-manager {
                home-manager = {
                    useGlobalPkgs = true;

                    # Same as specialArgs but for Home Manager
                    extraSpecialArgs = { 
                        inputs = inputs;
                    };
                    users = userConfigs;
                };
            }
        ];
    };

    # For the Home Manager NixOS module, not standalone
    mkUserModule = additionalImports: {
        imports = userImports additionalImports;
    };

    userImports = additionalImports: additionalImports ++ [
        catppuccin.homeManagerModules.catppuccin
        nixvim.homeManagerModules.nixvim
        impermanence.nixosModules.home-manager.impermanence
    ];
}
