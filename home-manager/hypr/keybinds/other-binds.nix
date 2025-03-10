rec

{
    allBinds = exitHyprland ++ screenshot ++ logout ++ lock;

    exitHyprland = [ " SHIFT, R, exit," ];
    screenshot = [ ", J, exec, grim -g \"$(slurp -w 0)\" - | swappy -f -" ];
    logout = [ " SHIFT, SEMICOLON, exec, wlogout --protocol layer-shell" ];
    lock = [ ", SEMICOLON, exec, swaylock" ];
}
