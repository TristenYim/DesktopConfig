## This is an attribute set of functions designed to assist 
## making waybar styles.
let
    catppuccin = (import ../theme/catppuccin-colors.nix);
in
{
    # These style options are defined globally since they don't change regardless of how
    # the waybar is customized. This function must only be called once per style.
    makeGlobal =
    let
        mkSimple = type: background: ''
            #${type} {
                background: ${background};
            }
        '';
    in
    ''
        * {
            border: none;
            border-radius: 0;
            font-family: "Merienda";
            font-weight: bold;
        }

        label.module {
            color: black;
        }

        tooltip {
            background: ${catppuccin.base};
            opacity: 0.8;
            border-radius: 10px;
            border-width: 2px;
            border-style: solid;
            border-color: ${catppuccin.surface0};
        }

        tooltip label{
            color: ${catppuccin.text};
        }

        window#waybar {
            background: transparent;
        }

        #workspaces {
            background: ${catppuccin.yellow};
            padding: 0;
        }

        #workspaces button {
            color: black;
            background: transparent;
        }

        #battery, #backlight, #network {
            color: white;
        }

        ${mkSimple "lock" catppuccin.maroon}
        ${mkSimple "trayicons" catppuccin.crust}
        ${mkSimple "audio" catppuccin.blue}
        ${mkSimple "hardware" catppuccin.mauve}
        ${mkSimple "mpris" catppuccin.pink}
        ${mkSimple "window" catppuccin.pink}
        ${mkSimple "workspaces button.active" catppuccin.peach}
        ${mkSimple "clock" catppuccin.green}
        ${mkSimple "config" catppuccin.teal}
    '';

    # This is to allow the sizing of the bar to be customized to ensure
    # the bar is readable on monitors with differing resolutions.
    # The style is assigned to the given name.
    makeUnique = name: borderRadius: paddingInternal: paddingGroup: fontSize: gapWidth:
    let
        borderString = "border-radius: ${toString borderRadius}px";
        paddingInside = "padding: 0px ${toString paddingInternal}px";
        paddingGrouped = "padding: ${toString((borderRadius - fontSize) / 2)}px ${toString paddingGroup}px";
        paddingUngrouped = "padding: ${toString((borderRadius - fontSize) / 2)}px ${toString(paddingInternal + paddingGroup)}px";
        gapString = toString gapWidth;
        gapHalfString = toString(gapWidth / 2);
        mkSimpleMembers = types: 
        let
            mkHeader = i: let 
                current = "#${builtins.elemAt types i}.${name}";
            in if i == builtins.length types - 1 then current else current + ", " + mkHeader (i + 1);
        in ''
            ${mkHeader 0} {
                ${paddingInside};
            }
        '';
    in
    ''
        .${name} {
            font-size: ${toString fontSize}px;
        }

        #lock.${name} {
            ${borderString};
            ${paddingGrouped};
            margin-left: ${gapHalfString}px;
        }

        #mpris.${name} {
            ${borderString};
            ${paddingUngrouped};
            margin-left: ${gapString}px;
        }

        #window.${name} {
            ${borderString};
            ${paddingUngrouped};
            margin-left: ${gapString}px;
        }

        #workspaces.${name} {
            ${borderString};
            margin-right: ${gapString}px;
        }

        #workspaces.${name} button {
            ${borderString};
            ${paddingInside};
            min-width: ${toString borderRadius}px;
        }

        #clock.${name} {
            ${borderString};
            ${paddingUngrouped};
        }

        #config.${name} {
            ${borderString};
            ${paddingGrouped};
            margin-left: ${gapString}px;
        }

        #custom-nix_config.${name} {
            padding: ${toString((borderRadius - fontSize) / 2)}px;
            padding-left: ${toString(paddingInternal * 1 / 4)};
            padding-right: ${toString(paddingInternal * 5 / 4)};
        }

        #trayicons.${name} {
            ${borderString};
            ${paddingGrouped};
            margin-left: ${gapString}px;
        }

        #audio.${name} {
            ${borderString};
            ${paddingGrouped};
            margin-right: ${gapString}px;
        }

        #pulseaudio.${name}.microphone {
            ${paddingInside};
        }

        #hardware.${name} {
            ${borderString};
            ${paddingGrouped};
            margin-right: ${gapHalfString}px;
        }

        ${mkSimpleMembers [ "custom-power_btn" "idle_inhibitor" "tray" "battery" "backlight" "network" "pulseaudio" "cpu" "memory" ]}
    '';
}
