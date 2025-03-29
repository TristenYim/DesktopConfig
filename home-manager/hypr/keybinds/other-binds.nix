{ helpers }: rec

{
    allBinds = exitHyprland ++ screenshot ++ logout ++ lock ++ toggleUglyAFMode;

    exitHyprland = [ " SHIFT, R, exit," ];
    screenshot = [ ", J, exec, grim -g \"$(slurp -w 0)\" - | swappy -f -" ];
    logout = [ " SHIFT, SEMICOLON, exec, wlogout --protocol layer-shell" ];
    lock = [ ", SEMICOLON, exec, swaylock" ];
    toggleUglyAFMode = helpers.toggleOptionsBind "W" "animations:enabled" "uglyAFModeDisabled";
}
