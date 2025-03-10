rec

{
    allBinds = appLauncher ++ browser ++ fileManager ++ terminal;

    appLauncher = [ ", SPACE, exec, rofi -theme $HOME/.config/rofi/run.rasi -show drun" ];
    browser = [ ", Q, exec, firefox-beta" ];
    fileManager = [ " SHIFT, U, exec, thunar" ", U, exec, [float;size 60% 60%] thunar" ];
    terminal = [ ", APOSTROPHE, exec, kitty" " SHIFT, APOSTROPHE, exec, [float;size 75% 75%] kitty" ];
}
