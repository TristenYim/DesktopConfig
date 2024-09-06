# Manages Hyprland plugins
# Note that since this is done using Home Manager, there is no need to use hyprpm

{ config, pkgs, lib, inputs, ... }: {
    options = {
        hycov-home.enable = lib.mkEnableOption "Enables the hycov plugin with Home Manager";
    };

    config = lib.mkIf config.hycov-home.enable
    {
        wayland.windowManager.hyprland = {
            plugins = [
                inputs.hycov.packages.${pkgs.system}.hycov
            ];

            settings = {
                bind = [
                    "$mainMod, TAB, hycov:enteroverview"
                    "$mainMod, TAB, submap, overview"
                ];

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
            extraConfig = ''
                submap = overview 

                # Move focus
                bind = , a, hycov:movefocus, leftcross
                bind = , e, hycov:movefocus, rightcross
                bind = , COMMA, hycov:movefocus, upcross
                bind = , o, hycov:movefocus, downcross
                bind = , left, hycov:movefocus, leftcross
                bind = , right, hycov:movefocus, rightcross
                bind = , up, hycov:movefocus, upcross
                bind = , down, hycov:movefocus, downcross
                
                # Kill windows
                bind = , ESCAPE, killactive,
                bind = , mouse:273, killactive,
                
                # Enter workspace keybinds
                bind = , 1, hycov:leaveoverview
                bind = , 1, workspace, 1
                bind = , 1, submap, reset
                bind = , 2, hycov:leaveoverview
                bind = , 2, workspace, 2
                bind = , 2, submap, reset
                bind = , 3, hycov:leaveoverview
                bind = , 3, workspace, 3
                bind = , 3, submap, reset
                bind = , 4, hycov:leaveoverview
                bind = , 4, workspace, 4
                bind = , 4, submap, reset
                bind = , 5, hycov:leaveoverview
                bind = , 5, workspace, 5
                bind = , 5, submap, reset
                bind = , 6, hycov:leaveoverview
                bind = , 6, workspace, 6
                bind = , 6, submap, reset
                bind = , 7, hycov:leaveoverview
                bind = , 7, workspace, 7
                bind = , 7, submap, reset
                bind = , 8, hycov:leaveoverview
                bind = , 8, workspace, 8
                bind = , 8, submap, reset
                bind = , 9, hycov:leaveoverview
                bind = , 9, workspace, 9
                bind = , 9, submap, reset
                bind = , 0, hycov:leaveoverview
                bind = , 0, workspace, 10
                bind = , 0, submap, reset
                bind = , F1, hycov:leaveoverview
                bind = , F1, workspace, name:CHAT
                bind = , F1, submap, reset
                bind = , F2, hycov:leaveoverview
                bind = , F2, workspace, name:MAIL
                bind = , F2, submap, reset
                
                # Leave overview
                bind = , TAB, hycov:leaveoverview
                bind = , TAB, submap, reset
                bind = , RETURN, hycov:leaveoverview
                bind = , RETURN, submap, reset
                bind = , SPACE, hycov:leaveoverview
                bind = , SPACE, submap, reset
                bind = , mouse:272, hycov:leaveoverview
                bind = , mouse:272, submap, reset
                
                submap = reset
            '';
        };
    };
}
