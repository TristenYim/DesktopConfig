{ helpers }: rec

{
    allBinds = exitHyprland ++ screenshot ++ logout ++ lock ++ toggleLayout ++ toggleUglyAFMode;

    exitHyprland = [ " SHIFT, R, exit," ];
    screenshot = [ ", J, exec, uwsm app -- grim -g \"$(slurp -w 0)\" - | swappy -f -" ];
    logout = [ " SHIFT, SEMICOLON, exec, uwsm app -- wlogout --protocol layer-shell" ];
    lock = [ ", SEMICOLON, exec, uwsm app -- swaylock" ];
    toggleLayout = helpers.cycleOptionsBind "if [[ $state == dwindle ]]; then state=master; elif [[ $state == master ]]; then state=dwindle; fi" "L" "general:layout" "general:layout";
    toggleUglyAFMode = helpers.toggleOptionsBind "V" "animations:enabled" "\\$\"uglyAFModeDisabled\"";
}
