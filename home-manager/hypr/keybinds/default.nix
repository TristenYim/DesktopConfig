# These are all of my keybinds (except ones defined in plugins)

# See https://wiki.hyprland.org/Configuring/Binds/ for more info

{ config, lib, ... }: {
    options.apeiron.desktop.hyprland = {
        binds.default = lib.mkEnableOption "the default HyprDE binds";
    };

    config = lib.mkIf config.apeiron.desktop.hyprland.binds.default 
    {
        wayland.windowManager.hyprland = 

        let
            ## Helper functions used to abstract certain repetitive operations
            helpers = import ../helpers.nix { inherit lib; };

            ## Modules containing lists of binds. These lists can be added 
            ## together and modified to create a customized bind config
            workspaceBinds = import ./workspace-binds.nix { inherit helpers; };
            windowBinds = import ./window-binds.nix { inherit helpers; };
            otherBinds = import ./other-binds.nix { inherit helpers; };
            launchers = import ./launchers.nix;
        in

        {
            settings = {
                bind = (
                    helpers.prependSuper (
                        windowBinds.allBinds
                        ++ launchers.allBinds
                        ++ otherBinds.allBinds
                        ++ workspaceBinds.allBinds
                    )
                );
    
                bindm = helpers.prependSuper windowBinds.allBindms;
            };
        };
    };
}
