## This is an attribute set of functions designed to assist 
## making waybar styles.
let
    catppuccin = (import ../theme/catppuccin-colors.nix);
in
{
    # These style options are defined globally since they don't change regardless of how
    # the waybar is customized. This function must only be called once per style.
    makeGlobal =
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

        #lock {
            background: ${catppuccin.maroon};
        }

        #trayicons {
            background: ${catppuccin.crust};
        }

        #audio {
            background: ${catppuccin.blue};
        }

        #hardware {
            background: ${catppuccin.mauve};
        }

        #mpris {
            background: ${catppuccin.pink};
        }

        #window {
            background: ${catppuccin.pink};
        }

        #workspaces {
            background: ${catppuccin.yellow};
            padding: 0;
        }

        #workspaces button {
            color: black;
            background: transparent;
        }

        #workspaces button.active, #workspaces button:hover {
            background: ${catppuccin.peach};
        }

        #clock {
            background: ${catppuccin.green};
        }

        #config {
            background: ${catppuccin.teal};
        }

        #battery {
            color: white;
        }

        #backlight {
            color: white;
        }
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

        #custom-power_btn.${name} {
            ${paddingInside};
        }

        #custom-lock_screen.${name} {
            ${paddingInside};
        }

        #idle_inhibitor.${name} {
            ${paddingInside};
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

        #custom-updates.${name} {
            ${paddingInside};
        }

        #trayicons.${name} {
            ${borderString};
            ${paddingGrouped};
            margin-left: ${gapString}px;
        }

        #battery.${name} {
            ${paddingInside};
        }

        #backlight.${name} {
            ${paddingInside};
        }

        #tray.${name} {
            ${paddingInside};
        }

        #audio.${name} {
            ${borderString};
            ${paddingGrouped};
            margin-right: ${gapString}px;
        }

        #pulseaudio.${name} {
            ${paddingInside};
        }

        #pulseaudio.${name}.microphone {
            ${paddingInside};
        }

        #hardware.${name} {
            ${borderString};
            ${paddingGrouped};
            margin-right: ${gapHalfString}px;
        }

        #cpu.${name} {
            ${paddingInside};
        }

        #memory.${name} {
            ${paddingInside};
        }

        #temperature.${name} {
            ${paddingInside};
        }

        #temperature.${name}.critical {
            color: ${catppuccin.red};
        }

        #network.${name} {
            ${paddingInside};
        }
    '';
}
