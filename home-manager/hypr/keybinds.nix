{ config, pkgs, lib, ... }: {
    config = lib.mkIf config.hyprland-home.enable 
    {
        wayland.windowManager.hyprland.settings =
        {
            ###################
            ### KEYBINDINGS ###
            ###################

            # See https://wiki.hyprland.org/Configuring/Keywords/ for more
            "$mainMod" = "SUPER";

            #########################
            ### WINDOW MANAGEMENT ###
            #########################

            bind = [
                "$mainMod, ESCAPE, killactive,"
                "$mainMod, PERIOD, togglefloating,"
                "$mainMod, A, exec, swaylock"
                "$mainMod SHIFT, A, exec, wlogout --protocol layer-shell"
                "$mainMod SHIFT, R, exit,"
                # $mainMod, P, pseudo, # dwindle
                # $mainMod, COMMA, togglesplit, # dwindle

                # Move focus with mainMod + arrow keys
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up, movefocus, u"
                "$mainMod, down, movefocus, d"

                # Swap windows with mainMod + shift + arrow keys
                "$mainMod SHIFT, left, swapwindow, l"
                "$mainMod SHIFT, right, swapwindow, r"
                "$mainMod SHIFT, up, swapwindow, u"
                "$mainMod SHIFT, down, swapwindow, d"

                ##################
                ### WORKSPACES ###
                ##################

                # Switch workspaces with mainMod + [0-9]
                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"
                "$mainMod, 6, workspace, 6"
                "$mainMod, 7, workspace, 7"
                "$mainMod, 8, workspace, 8"
                "$mainMod, 9, workspace, 9"
                "$mainMod, 0, workspace, 10"

                # Specific-use workspaces
                "$mainMod, F1, workspace, name:CHAT"
                "$mainMod, F2, workspace, name:MAIL"

                # Move active window to a workspace with mainMod + SHIFT + [0-9]
                "$mainMod SHIFT, 1, movetoworkspace, 1"
                "$mainMod SHIFT, 2, movetoworkspace, 2"
                "$mainMod SHIFT, 3, movetoworkspace, 3"
                "$mainMod SHIFT, 4, movetoworkspace, 4"
                "$mainMod SHIFT, 5, movetoworkspace, 5"
                "$mainMod SHIFT, 6, movetoworkspace, 6"
                "$mainMod SHIFT, 7, movetoworkspace, 7"
                "$mainMod SHIFT, 8, movetoworkspace, 8"
                "$mainMod SHIFT, 9, movetoworkspace, 9"
                "$mainMod SHIFT, 0, movetoworkspace, 10"

                # Scroll through existing workspaces with mainMod + scroll
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"

                #################
                ### LAUNCHING ###
                #################

                "$mainMod, SPACE, exec, rofi -theme $HOME/.config/rofi/run.rasi -show drun"

                "$mainMod, APOSTROPHE, exec, kitty"
                "$mainMod SHIFT, APOSTROPHE, exec, [float;size 75% 75%] kitty" # General purpose floating terminal
                "$mainMod, U, exec, [float;size 60% 60%] thunar"
                "$mainMod SHIFT, U, exec, thunar"
                "$mainMod, J, exec, grim -g \"$(slurp -w 0)\" - | swappy -f -"
                "$mainMod, O, exec, firefox-beta"

                # These programs are in special workspaces
                "$mainMod, GRAVE, togglespecialworkspace, BTOP"
                "$mainMod, E, togglespecialworkspace, CIDER"
                "$mainMod, M, togglespecialworkspace, CONFIG"
            ];

            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = [
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];
        };
    };
}
