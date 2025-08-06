{ config, pkgs, lib, ... }: 
let
    cfg = config.apeiron.desktop.compositors.settings;
    fromHex = hex: "rgb(${lib.removePrefix "#" hex})";
in
{
    options.apeiron.desktop.compositors.hyprland = {
        enable = lib.mkEnableOption "Hyprland";
        uglyAFMode.default = lib.mkEnableOption "uglyAFMode in Hyprland by default";
    };
 
    config = lib.mkIf config.apeiron.desktop.compositors.hyprland.enable 
    {
        wayland.windowManager.hyprland = 
        {
            enable = true;

            # Wrap the package with nixGL, if applicable
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

                # Toggle for animations, shadows, and blur
                "$uglyAFModeDisabled" = !config.apeiron.desktop.compositors.hyprland.uglyAFMode.default;
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

                # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for more info
                workspace = [
                    "1, monitor:$mon1, default:true"
                    "name:CHAT, monitor:$mon1, on-created-empty:hyprctl dispatch exec uwsm app -- slack & uwsm app -- signal-desktop & uwsm app -- flatpak run --branch=stable --arch=x86_64 --command=com.discordapp.Discord com.discordapp.Discord --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=auto"
                    "name:MAIL, monitor:$mon1, on-created-empty:hyprctl dispatch exec uwsm app -- thunderbird"
                    "special:BTOP, on-created-empty: [maximize] uwsm app -- kitty btop"
                    "special:CIDER, on-created-empty: [float; size 1000 800; move 10 50] uwsm app -- cider"
                    "special:CONFIG, on-created-empty: [maximize] uwsm app -- kitty nvim $FLAKE/source"
                    "special:AGENDA, on-created-empty: [maximize] uwsm app -- kitty nvim ${config.programs.nixvim.plugins.orgmode.settings.org_agenda_files} +\"Org agenda a\""
                ];

                # Import compositor-agnostic settings, see ../compositor-options/settings.nix
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

                layerrule = [ "ignorezero, ^(rofi)$" ] ++ (cfg.rules.layers |> builtins.map ( rule:
                    let
                        mkParameter = value: prefix: xToString:
                            if value == null then [] else "${prefix}${xToString value}";
                    in
                        mkParameter rule.parameters.blur "blur" (x: ", ") + rule.namespace
                ));

                windowrulev2 = builtins.concatLists (cfg.rules.windows |> builtins.map ( rule:
                    let
                        mkMatcher = value: prefix: if value == "" then "" else ", ${prefix}:${value}";
                        mkParameter = value: prefix: xToString: 
                            if value == null then [] else [(
                                "${prefix}${xToString value}"
                                + mkMatcher rule.matchers.title "title"
                                + mkMatcher rule.matchers.appID "class"
                            )];
                    in
                        mkParameter rule.parameters.opacity "opacity " lib.strings.floatToString
                        ++ mkParameter rule.parameters.openFloating "float" (x: "")
                        ++ mkParameter rule.parameters.openFullscreen "maximize" (x: "")
                )) ++ [ "animation popin, class:^(thunar)$" ];
            };
        };
    };
}
