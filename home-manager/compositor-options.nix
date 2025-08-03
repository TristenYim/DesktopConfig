# Define and set options that are commonly found across multiple compositors.
# This ensures preferences are synced across-compositors.

{ lib, ... }: 
let
    catppuccin = import ./theme/catppuccin-colors.nix;

    # Simple functions to reduce options boilerplate
    mkIntOption = default: descriptionExtra: lib.mkOption {
        type = lib.types.int;
        inherit default;
        description = "Compositor-agnostic ${descriptionExtra}.";
    };
    mkFloatOption = default: descriptionExtra: lib.mkOption {
        type = lib.types.float;
        inherit default;
        description = "Compositor-agnostic ${descriptionExtra}.";
    };
    mkStringOption = default: descriptionExtra: lib.mkOption {
        type = lib.types.str;
        inherit default;
        description = "Compositor-agnostic ${descriptionExtra}.";
    };
in
{
    options.apeiron.desktop.compositors.settings = {
        aesthetics = {
            blur = {
                brightness = mkFloatOption 1.0 "blur brightness modifier";
                contrast = mkFloatOption 1.0 "blur contrast modifier";
                noise = mkFloatOption 0.0 "blur noise intensity";
                passes = mkIntOption 4 "blur pass count";
                radius = mkIntOption 4 "blur radius in pixels";
            };

            border = {
                radius = mkIntOption 5 "window corner radius in pixels";
                width = mkIntOption 2 "window border width in pixels";
                colors = {
                    focused = mkStringOption catppuccin.sky "focused window color hex";
                    unfocused = mkStringOption catppuccin.surface0 "unfocused window color hex";
                };
            };

            gaps = {
                inner = mkIntOption 5 "window gap width in pixels";
                outer = mkIntOption 10 "window border gap width in pixels";
            };

            # Note: Every compositor has a different shadow implementation, more tweaking may be required
            shadows = {
                color = mkStringOption catppuccin.crust "window shadow color hex";
                size = mkIntOption 8 "window shadow size in pixels";
            };

            unfocusedOpacity = mkFloatOption 0.7 "unfocused window opacity";
        };

        behavior = {
            workspaces.count = mkIntOption 10 "default number of workspaces or tags";
            layouts.master.ratio = mkFloatOption 0.75 "ratio of screen taken up by the master window";
        };

        input = {
            # XKB keyboard configuration, see https://wiki.archlinux.org/title/Xorg/Keyboard_configuration
            keyboard = {
                layouts = mkStringOption "us, us, us" "xkb keyboard layouts";
                variants = mkStringOption "dvorak, dvorak-intl, " "xkb keyboard variants";

                # Unintuitively, this default maps to LALT + RSHIFT, not RALT
                extraOptions = mkStringOption "grp:ralt_rshift_toggle" "xkb keyboard options";
            };
        };
    };
}
