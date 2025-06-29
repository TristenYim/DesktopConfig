{ config, pkgs, lib, hyprland, ... }: 

{
    imports = [
        ./hypridle.nix
        ./plugins.nix
        ./windows-workspaces.nix
        ./keybinds/default.nix
        ./environment/env_var.nix
        ./environment/env_var_nvidia.nix
    ];

    options.apeiron.desktop.hyprland = {
        enable = lib.mkEnableOption "Hyprland";
        uglyAFMode.default = lib.mkEnableOption "uglyAFMode in Hyprland by default";
    };
 
    config = lib.mkIf config.apeiron.desktop.hyprland.enable 
    {
        wayland.windowManager.hyprland = 
        {
            enable = true;
            package = 
              let
                unwrapped = pkgs.hyprland;
              in 
                if config.apeiron.nixGL.enable then config.lib.nixGL.wrap unwrapped else unwrapped;

            systemd.enable = false; # Required for UWSM
            settings = 
            {
                # Please note not all available settings / options are set here.
                # For a full list, see the wiki
                # https://wiki.hyprland.org/Configuring/Configuring-Hyprland/

                # Monitors must be manually configured per-computer, and is not included in the repo

                #####################
                ### LOOK AND FEEL ###
                #####################

                "$uglyAFModeDisabled" = !config.apeiron.desktop.hyprland.uglyAFMode.default; # Toggle for animations, shadows, and blur

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

                    shadow = {
                        enabled = "$uglyAFModeDisabled";
                        range = 4;
                        render_power = 3;
                        color = "rgba(1a1a1aee)";
                    };

                    # https://wiki.hyprland.org/Configuring/Variables/#blur
                    blur = {
                        enabled = "$uglyAFModeDisabled";
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
                    enabled = "$uglyAFModeDisabled";

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
                    enable_anr_dialog = false;
                    force_default_wallpaper = 2;
                    disable_autoreload = true;
                };

                render = {
                    explicit_sync = 1;
                    explicit_sync_kms = 1;
                };

                # Cry about it Vaxry
                ecosystem = {
                    no_update_news = true;
                    no_donation_nag = true;
                };
            };
        };
    };
}
