# Window rules and layer rules allow the compositor's configuration to
# change per-window and per-layer based on provided rules.

{ lib, ... }: 
let
    mkStringOption = description: lib.mkOption {
        type = lib.types.str;
        default = "";
        inherit description;
    };

    mkParameter = type: description: lib.mkOption {
        type = lib.types.nullOr type;
        default = null;
        inherit description;
    };

    windowRuleType = lib.types.submodule {
        options.matchers = {
            title = mkStringOption "Regex to match to the window title.";
            appID = mkStringOption "Regex to match to the window appID.";
        };
        options.parameters = {
            opacity = mkParameter lib.types.float "Additional window opacity modifier.";
            openFloating = mkParameter lib.types.bool "Whether to launch windows floating by default.";
            openFullscreen = mkParameter lib.types.bool "Whether to launch windows in fullscreen by default.";
        };
    };

    layerRuleType = lib.types.submodule {
        options.namespace = mkStringOption "Regex to match to the layer namespace.";
        options.parameters = {
            blur = mkParameter lib.types.bool "Whether to blur this layer.";
        };
    };
in
{
    options.apeiron.desktop.compositors.settings.rules = {
        windows = lib.mkOption {
            type = lib.types.listOf windowRuleType;
            default = [];
            description = "Compositor-agnostic window rules.";
        };
        layers = lib.mkOption {
            type = lib.types.listOf layerRuleType;
            default = [];
            description = "Compositor-agnostic layer rules.";
        };
    };

    config.apeiron.desktop.compositors.settings.rules = { 
        windows = [
            {
                matchers.title = "^(btop)$";
                parameters.opacity = 0.6;
            }
            {
                matchers.appID = "^(feh)$";
                parameters.openFloating = true;
            }
            {
                matchers.appID = "^(kitty)$";
                parameters.opacity = 0.8;
            }
            {
                matchers.appID = "^(mousepad)$";
                parameters.opacity = 0.8;
            }
            {
                matchers.appID = "^(openrgb)$";
                parameters.opacity = 0.65;
                parameters.openFloating = true;
                parameters.openFullscreen = true;
            }
            {
                matchers.appID = "^(org.pulseaudio.pavucontrol)$";
                parameters.opacity = 0.65;
                parameters.openFloating = true;
            }
            {
                matchers.appID = "^(io.github.Qalculate.qalculate-qt)$";
                parameters.opacity = 0.65;
                parameters.openFloating = true;
            }
            {
                matchers.appID = "^(thunar)$";
                parameters.opacity = 0.8;
                parameters.openFloating = true;
            }
            {
                matchers.appID = "^(Zoom)$";
                parameters.openFloating = true;
            }
        ];

        layers = [
            {
                namespace = "^(rofi)$";
                parameters.blur = true;
            }
            {
                namespace = "^(gtk-layer-shell)$";
                parameters.blur = true;
            }
            {
                namespace = "^(logout_dialog)$";
                parameters.blur = true;
            }
        ];
    };
}
