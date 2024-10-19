# Declares Hyprland environment variables
# Due to the existence of Home Manager, this is most likely redundant

# See https://wiki.hyprland.org/Configuring/Environment-variables/ for more info

{ config, pkgs, lib, ... }: {
    config = lib.mkIf config.hyprland-home.enable 
    {
        wayland.windowManager.hyprland.settings.env = [ 
            "XCURSOR_SIZE,24"

            # Set a GTK theme manually, for those who want to avoid appearance tools such as lxappearance or nwg-look
            #env = GTK_THEME,

            # Set your cursor theme. The theme needs to be installed and readable by your user.
            #env = XCURSOR_THEME,

            #XDG Specifications
            "XDG_CURRENT_DESKTOP,Hyprland"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"

            # Toolkit Backend Variables

            # GTK: Use wayland if available, fall back to x11 if not.
            "GDK_BACKEND,wayland,x11"

            # QT: Use wayland if available, fall back to x11 if not.
            "QT_QPA_PLATFORM,wayland;xcb"

            # Run SDL2 applications on Wayland. Remove or set to x11 if games that 
            # provide older versions of SDL cause compatibility issues
            "SDL_VIDEODRIVER,wayland" 

            # Clutter package already has wayland enabled, this variable 
            #will force Clutter applications to try and use the Wayland backend
            "CLUTTER_BACKEND,wayland"

            # QT Variables

            # (From the QT documentation) enables automatic scaling, based on the monitor’s pixel density
            # https://doc.qt.io/qt-5/highdpi.html
            "QT_AUTO_SCREEN_SCALE_FACTOR,1"

            # Disables window decorations on QT applications
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

            # Tells QT based applications to pick your theme from qt5ct, use with Kvantum.
            "QT_QPA_PLATFORMTHEME,qt5ct"

            # Required for Firefox hardware acceleration
            "MOZ_X11_EGL,1"
            "MOZ_DISABLE_RDD_SANDBOX,1"

            # Use native wayland for electron apps
            "NIXOS_OZONE_WL,1"
        ];
    };
}
