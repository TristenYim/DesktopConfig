{ config, pkgs, lib, ... }: {
    config = lib.mkIf config.hyprland-home.enable 
    {
        wayland.windowManager.hyprland.settings =
        {
            ##############################
            ### WINDOWS AND WORKSPACES ###
            ##############################

            # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
            # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

            windowrulev2 = [

                ###############
                ### OPACITY ###
                ###############

                "opacity 0.6 0.6, title:^(btop)$"
                "opacity 0.8 0.8, class:^(kitty)$"
                "opacity 0.8 0.8, class:^(mousepad)$"
                "opacity 0.65 0.65, class:^(nwg-look)$"
                "opacity 0.65 0.65, class:^(openrgb)$"
                "opacity 0.65 0.65, class:^(org.pulseaudio.pavucontrol)$"
                "opacity 0.65 0.65, class:^(qalculate-gtk)$"
                "opacity 0.65 0.65, class:^(qt5ct)$"
                "opacity 0.65 0.65, class:^(qt6ct)$"
                "opacity 0.8 0.8, class:^(thunar)$"

                #############
                ### FLOAT ###
                #############

                "float, class:^(nm-connection-editor)$"
                "float, class:^(nwg-look)$"
                "float, class:^(openrgb)$"
                "float, class:^(org.pulseaudio.pavucontrol)"
                "float, class:^(qalculate-gtk)$"
                "float, class:^(qt6ct)$"
                "float, class:^(qt5ct)$"
                "float, title:^(update-sys)$"
                "float, class:^(Zoom)$"

                ############
                ### MISC ###
                ############

                "center, class:^(feh)$"
                "float, class:^(feh)$"
                "size 75% 75%, class:^(feh)$"
                "animation popin, class:^(kitty)$,title:^(update-sys)$"
                "animation popin, class:^(thunar)$"
                "maximize, class:^(openrgb)$"
                # "opaque, class:^(photo.exe)$"
                # "nodim, class:^(photo.exe)$"
            ];

            ##############
            ### LAYERS ###
            ##############

            layerrule = [
                "blur, ^(rofi)$"
                "ignorezero, ^(rofi)$"
                "blur, ^(logout_dialog)$"
                "blur, ^(gtk-layer-shell)$"
            ];

            ##################
            ### WORKSPACES ###
            ##################

            workspace = [
                "1, monitor:$mon1, default:true"
                "name:Chat, monitor:$mon2, on-created-empty:hyprctl dispatch exec slack && /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=com.discordapp.Discord com.discordapp.Discord --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=auto"
            ];

            ##########################
            ### SPECIAL WORKSPACES ###
            ##########################
        };
    };
}
