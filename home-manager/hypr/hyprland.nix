{ config, pkgs, lib, hyprland, ... }: 
let
    cfg = config.apeiron.desktop.compositors.settings;
    fromHex = hex: "rgb(${lib.removePrefix "#" hex})";
in
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
                # Refer to https://wiki.hyprland.org/Configuring/Variables for more

                # Note monitors must be manually configured per-user

                # Import compositor-agnostic settings, see ../compositor-options.nix
                general.gaps_in = cfg.aesthetics.gaps.inner;
                general.gaps_out = cfg.aesthetics.gaps.outer;
                general.border_size = cfg.aesthetics.border.width;
                general."col.active_border" = fromHex cfg.aesthetics.border.colors.focused;
                general."col.inactive_border" = fromHex cfg.aesthetics.border.colors.unfocused;
                decoration.rounding = cfg.aesthetics.border.radius;
                decoration.blur.contrast = cfg.aesthetics.blur.contrast;
                decoration.blur.brightness = cfg.aesthetics.blur.brightness;
                decoration.blur.noise = cfg.aesthetics.blur.noise;
                decoration.blur.size = cfg.aesthetics.blur.radius;
                decoration.blur.passes = cfg.aesthetics.blur.passes;
                decoration.inactive_opacity = cfg.aesthetics.unfocusedOpacity;
                decoration.shadow.color = fromHex cfg.aesthetics.shadows.color;
                decoration.shadow.range = cfg.aesthetics.shadows.size;
                input.kb_layout = cfg.input.keyboard.layouts;
                input.kb_variant = cfg.input.keyboard.variants;
                input.kb_options = cfg.input.keyboard.extraOptions;
                master.mfact = cfg.behavior.layouts.master.ratio;

                # Toggle for animations, shadows, and blur
                "$uglyAFModeDisabled" = !config.apeiron.desktop.hyprland.uglyAFMode.default;
                animations.enabled = "$uglyAFModeDisabled";
                decoration.blur.enabled = "$uglyAFModeDisabled";
                decoration.shadow.enabled = "$uglyAFModeDisabled";

                # Set the default layout to master/stack
                general.layout = "master";

                # Dim every window except the one in focus
                decoration = {
                    dim_inactive = true;
                    dim_strength = 0.3;
                };

                # TODO Customize animations
                animations = {
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

                input.sensitivity = "-0.2"; # -1.0 - 1.0, 0 means no modification.

                gestures.workspace_swipe = "off"; # This gesture was too prone to accidentally activating

                misc = {
                    enable_anr_dialog = false; # "App not responding" ends up being more annoying than useful
                    force_default_wallpaper = 2; # Force hypr-chan
                    disable_autoreload = true; # Not necessary with nix
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
