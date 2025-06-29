{ helpers }: rec

{
    allBinds = exitHyprland ++ screenshot ++ logout ++ lock ++ toggleUglyAFMode;

    exitHyprland = [ " SHIFT, R, exit," ];
    screenshot = [ ", J, exec, uwsm app -- grim -g \"$(slurp -w 0)\" - | swappy -f -" ];
    logout = [ " SHIFT, SEMICOLON, exec, uwsm app -- wlogout --protocol layer-shell" ];
    lock = [ ", SEMICOLON, exec, uwsm app -- swaylock" ];
    toggleUglyAFMode = helpers.toggleOptionsBind "V" "animations:enabled" "uglyAFModeDisabled";
}
