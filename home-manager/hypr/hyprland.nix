{ config, pkgs, lib, inputs, ... }: 

# Import the nixGL wrapper function.
let nixGLWrap = import ../nixGL/nixGLWrapper.nix { 
    inherit config pkgs; 
};
in {
    imports = [
        ./hypridle.nix
        ./keybinds.nix
        ./plugins.nix
        ./windows-workspaces.nix
        ./environment/env_var.nix
        ./environment/env_var_nvidia.nix
    ];

    options = {
        hyprland-home.enable = lib.mkEnableOption "Enables Hyprland with Home Manager";
    };
 
    config = lib.mkIf config.hyprland-home.enable 
    {
        wayland.windowManager.hyprland = 
        {
            enable = true;
            # package = lib.mkDefault (nixGLWrap pkgs.hyprland); # For hycov
            package = lib.mkDefault (nixGLWrap inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland);
            settings = 
            {
                # Please note not all available settings / options are set here.
                # For a full list, see the wiki
                # https://wiki.hyprland.org/Configuring/Configuring-Hyprland/

                # Monitors must be manually configured per-computer, and is not included in the repo

                #################
                ### AUTOSTART ###
                #################

                # Autostart necessary processes (like notifications daemons, status bars, etc.)
                # Or execute your favorite apps at launch like this:

                exec-once = [
                    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
                    "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
                    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
                    "blueman-applet"
                    "nm-applet --indicator"
                    "wl-paste --watch cliphist store"
                ];

                #####################
                ### LOOK AND FEEL ###
                #####################

                # Refer to https://wiki.hyprland.org/Configuring/Variables/

                # https://wiki.hyprland.org/Configuring/Variables/#general
                general = {
                    gaps_in = 5;
                    gaps_out = 10;

                    border_size = 2;

                    # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
                    # Note that the catppuccin module allows these variables to be referenced outside nix code
                    "col.active_border" = "$sky";
                    "col.inactive_border" = "$surface0";

                    # Set to true enable resizing windows by clicking and dragging on borders and gaps
                    resize_on_border = false;

                    # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
                    allow_tearing = false;

                    layout = "dwindle";
                };

                # https://wiki.hyprland.org/Configuring/Variables/#decoration
                decoration = {
                    rounding = 5;
    
                    # Change transparency of focused and unfocused windows
                    inactive_opacity = "0.7";

                    drop_shadow = true;
                    shadow_range = 4;
                    shadow_render_power = 3;
                    "col.shadow" = "rgba(1a1a1aee)";

                    # https://wiki.hyprland.org/Configuring/Variables/#blur
                    blur = {
                        enabled = true;
                        ignore_opacity = true;
                        size = 4;
                        passes = 4;
                        new_optimizations = true;
                        contrast = "1.0";
                        noise = "0.0";
                    };

                    blurls = "lockscreen";
                    dim_inactive = true;
                        dim_strength = 0.3;
                };

                # See https://wiki.hyprland.org/Configuring/Variables/#animations for all options
                animations = {
                    enabled = true;

                    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

                    bezier = "myBezier, 0.10, 0.9, 0.1, 1.05";

                    animation = [
                        "windows, 1, 7, myBezier, slide"
                        "windowsOut, 1, 7, myBezier, slide"
                        "border, 1, 10, default"
                        "borderangle, 1, 8, default"
                        "fade, 1, 7, default"
                        "workspaces, 1, 6, default"
                        "specialWorkspace, 1, 6, default, slidefadevert -100%"
                    ];
                };

                ##############
                ### LAYOUT ###
                ##############

                # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
                dwindle = {
                    pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                    preserve_split = true; # you probably want this
                };

                # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
                master = {
                    new_status = "master";
                };

                #############
                ### INPUT ###
                #############

                # See https://wiki.hyprland.org/Configuring/Variables/#input for all options
                input = {
                    kb_layout = "us, us, us";
                    kb_variant = "dvorak, dvorak-intl, "; # A blank value implies qwerty
                    kb_model = "";
                    kb_options = "grp:ralt_rshift_toggle"; # Unintuitively, this is LALT + RSHIFT, not RALT
                    kb_rules = "";

                    follow_mouse = 1;

                    touchpad = {
                        natural_scroll = false;
                    };

                    sensitivity = "-0.2"; # -1.0 - 1.0, 0 means no modification.
                };

                # See https://wiki.hyprland.org/Configuring/Variables/#gestures for all options
                gestures = {
                    workspace_swipe = "off";
                };

                #############
                ### OTHER ###
                #############

                # See https://wiki.hyprland.org/Configuring/Variables/#misc for all options
                misc = {
                    force_default_wallpaper = 2;
                    disable_autoreload = true;
                };

                render = {
                    explicit_sync = 1;
                    explicit_sync_kms = 1;
                };
            };
        };
    };
}
