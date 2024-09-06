# Window, workspace, and layer rules

{ config, pkgs, lib, ... }: {
    config = lib.mkIf config.hyprland-home.enable 
    {
        wayland.windowManager.hyprland.settings =
        {
            # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more info
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
                "float, class:^(photo.exe)$"

                ############
                ### MISC ###
                ############

                "center, class:^(feh)$"
                "float, class:^(feh)$"
                "size 75% 75%, class:^(feh)$"
                "animation popin, class:^(kitty)$,title:^(update-sys)$"
                "animation popin, class:^(thunar)$"
                "maximize, class:^(openrgb)$"
                "noblur, class:^(photo.exe)$"
                "noborder, class:^(photo.exe)$"
                "nodim, class:^(photo.exe)$"
                # "nomaxsize, class:^(photo.exe)$"
                # "norounding, class:^(photo.exe)$" # Does not exist in 0.41.2
                # "suppressevent fullscreen, class:^(photo.exe)$"
                # "fullscreenstate 0 2, class:^(photo.exe)$" # Does not exist in 0.41.2
            ];

            # See https://wiki.hyprland.org/Configuring/Window-Rules/#layer-rules for more info
            layerrule = [
                "blur, ^(rofi)$"
                "ignorezero, ^(rofi)$"
                "blur, ^(logout_dialog)$"
                "blur, ^(gtk-layer-shell)$"
            ];

            # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for more info
            workspace = [
                "1, monitor:$mon1, default:true"
                "name:CHAT, monitor:$mon1, on-created-empty:hyprctl dispatch exec slack && flatpak run --branch=stable --arch=x86_64 --command=com.discordapp.Discord com.discordapp.Discord --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=auto"
                "name:MAIL, monitor:$mon1, on-created-empty:hyprctl dispatch exec thunderbird"
                "special:BTOP, on-created-empty: [maximize] kitty btop"
                "special:CIDER, on-created-empty: [float; size 1000 800; move 10 50] cider"
                "special:CONFIG, on-created-empty: [maximize] kitty nvim /etc/nixos"
            ];
        };
    };
}
