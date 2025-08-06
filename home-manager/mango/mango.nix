# MangoWC configuration.

# See https://github.com/DreamMaoMao/mangowc/wiki
# for more information on conifuring.

{ config, lib, myLib, ... }: 
let
    cfg = config.apeiron.desktop.compositors.settings;
    argbFromHex = hex: "0x${lib.removePrefix "#" hex}ff";
    boolToString = v: if v then "1" else "0";
in
{
    options.apeiron.desktop.compositors.mango.enable = lib.mkEnableOption "MangoWC";

    config.wayland.windowManager.mango = lib.mkIf config.apeiron.desktop.compositors.mango.enable {
        enable = true;
        systemd.enable = true;

        configAttrs = {
            exec-once = [ (lib.getExe config.programs.waybar.package) ]; # Required until user services stop breaking

            env = [
                # Toolkit rendering backends
                "GDK_BACKEND,wayland,x11"
                "QT_QPA_PLATFORM,wayland;xcb"

                # QT settings
                "QT_AUTO_SCREEN_SCALE_FACTOR,1"
                "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

                # Firefox settings
                "MOZ_X11_EGL,1"
                "MOZ_DISABLE_RDD_SANDBOX,1"

                # Prefer native wayland in Electron apps
                "NIXOS_OZONE_WL,1"
            ] ++ (if ! config.apeiron.nvidia.enable then [ ] else [
                "LIBVA_DRIVER_NAME,nvidia"
                "__GLX_VENDOR_LIBRARY_NAME,nvidia"
                "NVD_BACKEND,direct"
            ]);

            blur = 1; # Enable blur
            blur_layer = 1; # Enable layer blur
            blur_optimized = 0; # Blur in realtime instead of just based on the wallpaper
            focus_cross_monitor = 1; # Allows directional dispatchers to cross monitors
            shadows = 1; # Enable shadows

            tagrule = [
                "id:7,layout_name:scroller"
                "id:8,layout_name:scroller"
                "id:9,layout_name:scroller"
            ];

            # Import compositor-agnostic settings, see ../compositor-options/settings.nix
            blur_params_brightness = cfg.aesthetics.blur.brightness;
            blur_params_contrast = cfg.aesthetics.blur.contrast;
            blur_params_noise = cfg.aesthetics.blur.noise;
            blur_params_num_passes = cfg.aesthetics.blur.passes;
            blur_params_radius = cfg.aesthetics.blur.radius;
            border_radius = cfg.aesthetics.border.radius;
            borderpx = cfg.aesthetics.border.width;
            focuscolor = argbFromHex cfg.aesthetics.border.colors.focused;
            scratchpadcolor = argbFromHex cfg.aesthetics.border.colors.focused;
            bordercolor = argbFromHex cfg.aesthetics.border.colors.unfocused;
            gappinh = cfg.aesthetics.gaps.inner;
            gappinv = cfg.aesthetics.gaps.inner;
            gapponh = cfg.aesthetics.gaps.outer;
            gapponv = cfg.aesthetics.gaps.outer;
            shadowscolor = argbFromHex cfg.aesthetics.shadows.color;
            shadows_size = cfg.aesthetics.shadows.size;
            unfocused_opacity = cfg.aesthetics.unfocusedOpacity;
            default_mfact = cfg.behavior.layouts.master.ratio;
            xkb_rules_layout = cfg.input.keyboard.layouts;
            xkb_rules_variant = cfg.input.keyboard.variants;
            xkb_rules_options = cfg.input.keyboard.extraOptions;

            layerrule = cfg.rules.layers |> builtins.map ( rule:
                let
                    mkParameter = value: prefix: xToString:
                        if value == null then [] else "${prefix}${xToString value}";
                in
                    mkParameter (if builtins.isBool rule.parameters.blur then ! rule.parameters.blur else null) "noblur:" (x: "${boolToString x},") + "layer_name:" + rule.namespace
            );

            windowrule = (cfg.rules.windows |> builtins.map ( rule:
                    let
                        mkElem = value: prefix: valueToString: if (value == "" || value == null) then [] else [ "${prefix}:${valueToString value}" ];
                    in
                        lib.concatStringsSep "," <| builtins.concatLists <| myLib.mapCalls (mkElem) [
                            [ rule.parameters.opacity "focused_opacity" (v: lib.strings.floatToString v) ]
                            [ rule.parameters.opacity "unfocused_opacity" (v: lib.strings.floatToString v) ]
                            [ rule.parameters.openFloating "isfloating" (v: boolToString v) ]
                            [ rule.parameters.openFullscreen "isfullscreen" (v: boolToString v) ]
                            [ rule.matchers.appID "appid" (v: v) ]
                            [ rule.matchers.title "title" (v: v) ]
                        ]
                ))
                ++ [
                    # Required to make named scratchpads work correctly
                    "focused_opacity:0.800000,unfocused_opacity:0.800000,isfullscreen:1,isnamedscratchpad:1,appid:scratchpad-agenda"
                    "focused_opacity:0.800000,unfocused_opacity:0.800000,isfullscreen:1,isnamedscratchpad:1,appid:scratchpad-btop"
                    "focused_opacity:0.800000,unfocused_opacity:0.800000,isfullscreen:1,isnamedscratchpad:1,appid:scrachpad-cider"
                    "focused_opacity:0.800000,unfocused_opacity:0.800000,isfullscreen:1,isnamedscratchpad:1,appid:scratchpad-config"
                ];
        };
    };
}
