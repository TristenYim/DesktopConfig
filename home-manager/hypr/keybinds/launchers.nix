rec

{
    allBinds = appLauncher ++ browser ++ fileManager ++ terminal;

    appLauncher = [ ", SPACE, exec, uwsm app -- rofi -theme $HOME/.config/rofi/run.rasi -show drun -run-command \"uwsm app -- {cmd}\"" ];
    browser = [ ", Q, exec, uwsm app -- firefox-beta" ];
    fileManager = [ " SHIFT, U, exec, uwsm app -- thunar" ", U, exec, [float;size 60% 60%] uwsm app -- thunar" ];
    terminal = [ ", APOSTROPHE, exec, uwsm app -- kitty" " SHIFT, APOSTROPHE, exec, [float;size 75% 75%] uwsm app -- kitty" ];
}
