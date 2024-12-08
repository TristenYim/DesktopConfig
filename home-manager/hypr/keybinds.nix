# These are all of my keybinds (except ones defined in plugins)

# See https://wiki.hyprland.org/Configuring/Binds/ for more info

{ config, lib, ... }: {
    config = lib.mkIf config.hyprland-home.enable 
    {
        wayland.windowManager.hyprland = 
        let
            helpers = import ./helpers.nix { inherit lib; };

            # These binds are shared between the main layout and altl submap,
            # with the only difference being that in the main submap, SUPER
            # must also be held.
            sharedBinds = 
                # General window management
                [
                    ", ESCAPE, killactive,"
                    ", BACKSPACE, killactive,"
                    ", PERIOD, togglefloating,"
                    # ", P, pseudo," # dwindle
                    # ", COMMA, togglesplit," # dwindle
                ]

                # Move focus
                ++ helpers.bindsWithSameDispatcher [ ", LEFT" ", A" ] "movefocus, l"
                ++ helpers.bindsWithSameDispatcher [ ", RIGHT" ", E" ] "movefocus, r"
                ++ helpers.bindsWithSameDispatcher [ ", UP" ", COMMA" ] "movefocus, u"
                ++ helpers.bindsWithSameDispatcher [ ", DOWN" ", O" ] "movefocus, d"

                # Swap windows
                ++ helpers.bindsWithSameDispatcher [ " SHIFT, LEFT" ", H" ] "swapwindow, l"
                ++ helpers.bindsWithSameDispatcher [ " SHIFT, RIGHT" ", N" ] "swapwindow, r"
                ++ helpers.bindsWithSameDispatcher [ " SHIFT, UP" ", C" ] "swapwindow, u"
                ++ helpers.bindsWithSameDispatcher [ " SHIFT, DOWN" ", T" ] "swapwindow, d"

                # Move (window to) workspace
                ++ helpers.bindForEachWorkspaceSelf "" "workspace" 
                ++ helpers.bindForEachWorkspaceSelf " SHIFT" "movetoworkspace"

                # Specific-use workspaces
                ++ [
                    ", F1, workspace, name:CHAT"
                    ", F2, workspace, name:MAIL"
                ]
    
                # Scroll through existing workspaces
                ++ [
                    ", mouse_down, workspace, e+1"
                    ", mouse_up, workspace, e-1"
                ];
        in
        {
            settings = {
                # See https://wiki.hyprland.org/Configuring/Keywords/ for more info
                bind = (
                    # System
                    helpers.prependSuper[
                        ", SEMICOLON, exec, swaylock"
                        " SHIFT, SEMICOLON, exec, wlogout --protocol layer-shell"
                        " SHIFT, R, exit,"
                    ] 
    
                    # Enter submaps
                    ++ [ ", ALT_L, submap, altl" ]

                    ++ helpers.prependSuper sharedBinds

                    ++ helpers.prependSuper [
                        # Launching
                        ", SPACE, exec, rofi -theme $HOME/.config/rofi/run.rasi -show drun"
    
                        ", APOSTROPHE, exec, kitty"
                        " SHIFT, APOSTROPHE, exec, [float;size 75% 75%] kitty" # General purpose floating terminal
                        ", U, exec, [float;size 60% 60%] thunar"
                        " SHIFT, U, exec, thunar"
                        ", J, exec, grim -g \"$(slurp -w 0)\" - | swappy -f -"
                        ", Q, exec, firefox-beta"
    
                        # These programs are in special workspaces
                        ", GRAVE, togglespecialworkspace, BTOP"
                        ", P, togglespecialworkspace, CIDER"
                        ", M, togglespecialworkspace, CONFIG"
                    ]
                );
    
                # Move/resize windows
                bindm = helpers.prependSuper [
                    ", mouse:272, movewindow"
                    ", mouse:273, resizewindow"
                ];
            };

            ###############
            ### SUBMAPS ###
            ###############

            extraConfig = (helpers.makeSubmap
                "altl"
                (
                    # Exit submap
                    helpers.bindsWithSameDispatcher [ ", ALT_L" ", ENTER" ", SUPER_L" ] "submap, reset"
                    ++ sharedBinds
                )
                [
                    # Move/resize windows
                    ", mouse:272, movewindow"
                    ", mouse:273, resizewindow"
                ]
            );
        };
    };
}
