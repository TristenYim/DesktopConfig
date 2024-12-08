# Manages Hyprland plugins
# Note that since this is done using Home Manager, there is no need to use hyprpm

{ config, pkgs, lib, inputs, ... }: {
    options = {
        hycov-home.enable = lib.mkEnableOption "Enables the hycov plugin with Home Manager";
    };

    config = lib.mkIf config.hycov-home.enable
    {
        wayland.windowManager.hyprland = 
        let
            helpers = import ./helpers.nix { inherit lib; };
        in
        {
            plugins = [
                inputs.hycov.packages.${pkgs.system}.hycov
            ];

            settings = {
                bind = helpers.bindWithManyDispatchers "SUPER, TAB" [ "hycov:enteroverview" "submap, overview" ];

                # See https://github.com/DreamMaoMao/hycov?tab=readme-ov-file#usage-hyprlandconf for more
                plugin = {
                    hycov = {
                        "overview_gappo" = 60; # gaps width from screen edge
                        "overview_gappi" = 24; # gaps width from clients
                        "enable_hotarea" = 0; # enable mouse cursor hotarea, when cursor enter hotarea, it will toggle overview
                        "enable_click_action" = 0; # enable mouse left button jump and right button kill in overview mode
                        "hotarea_monitor" = "all"; # monitor name which hotarea is in, default is all
                        "hotarea_pos" = 1; # position of hotarea (1: bottom left, 2: bottom right, 3: top left, 4: top right)
                        "hotarea_size" = 10; # hotarea size, 10x10
                        "swipe_fingers" = 4; # finger number of gesture,move any directory
                        "move_focus_distance" = 100; # distance for movefocus,only can use 3 finger to move
                        "enable_gesture" = 0; # enable gesture
                        "auto_exit" = 0; # enable auto exit when no client in overview
                        "auto_fullscreen" = 0; # auto make active window maximize after exit overview
                        "only_active_workspace" = 0; # only overview the active workspace
                        "only_active_monitor" = 0; # only overview the active monitor
                        "enable_alt_release_exit" = 0; # alt switch mode arg,see readme for detail
                        "alt_replace_key" = "Super_L"; # alt switch mode arg,see readme for detail
                        "alt_toggle_auto_next" = 0; # auto focus next window when toggle overview in alt switch mode
                        "click_in_cursor" = 1; # when click to jump,the target window is find by cursor, not the current focus window.
                        "hight_of_titlebar" = 0; # height deviation of title bar height
                        "show_special" = 0; # show windows in special workspace in overview.
                        "raise_float_to_top" = 1; # raise the window that is floating before to top after leave overview mode
                    };
                };
            };

            # As far as I can tell, submaps must be declared in hyprland syntax due to the dependence on order
            extraConfig = (helpers.makeSubmap
                "overview"
                (
                    # Move focus
                    helpers.bindsWithSameDispatcher [ ", A" ", LEFT" ] "hycov:movefocus, leftcross"
                    ++ helpers.bindsWithSameDispatcher [ ", E" ", RIGHT" ] "hycov:movefocus, rightcross"
                    ++ helpers.bindsWithSameDispatcher [ ", COMMA" ", UP" ] "hycov:movefocus, upcross"
                    ++ helpers.bindsWithSameDispatcher [ ", O" ", DOWN" ] "hycov:movefocus, downcross"

                    # Kill windows
                    ++ helpers.bindsWithSameDispatcher
                        [ ", ESCAPE" ", BACKSPACE" ", mouse:273" ] "killactive"

                    # Enter workspace keybinds
                    ++ helpers.bindForEachWorkspace "" "hycov:leaveoverview"
                    ++ helpers.bindForEachWorkspaceSelf "" "workspace"
                    ++ helpers.bindForEachWorkspace "" "submap, reset"

                    # Leave overview
                    ++ helpers.bindsWithSameDispatcher
                        [ ", TAB" ", RETURN" ", SPACE" ", mouse:272" ] "hycov:leaveoverview"
                    ++ helpers.bindsWithSameDispatcher
                        [ ", TAB" ", RETURN" ", SPACE" ", mouse:272"] "submap, reset"

                    ++ helpers.bindWithManyDispatchers
                        ", F1" [ "hycov:leaveoverview" "workspace, name:CHAT" "submap, reset" ]
                    ++ helpers.bindWithManyDispatchers 
                        ", F1" [ "hycov:leaveoverview" "workspace, name:MAIL" "submap, reset"]
                )
                [] 
            );
        };
    };
}
