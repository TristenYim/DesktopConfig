{ helpers }: rec

{
    ## Note: This excludes resizeWindow since those are mousebinds (bindm instead of just bind)
    allBinds = kill ++ float ++ moveFocus ++ swapWindows ++ cycleMaster;
    allBindms = moveWindow ++ resizeWindow;

    ## Kills active window
    kill = [ ", ESCAPE, killactive," ", BACKSPACE, killactive," ];

    ## Toggles floating state of the active window
    float = [ ", PERIOD, togglefloating," ];

    ## Switches focus in the given direction
    moveFocus = 
        helpers.bindsWithSameDispatcher [ ", LEFT" ", A" ] "movefocus, l"
        ++ helpers.bindsWithSameDispatcher [ ", RIGHT" ", E" ] "movefocus, r"
        ++ helpers.bindsWithSameDispatcher [ ", UP" ", COMMA" ] "movefocus, u"
        ++ helpers.bindsWithSameDispatcher [ ", DOWN" ", O" ] "movefocus, d";

    ## Swaps windows in the given direction
    swapWindows =
        helpers.bindsWithSameDispatcher [ " SHIFT, LEFT" ", H" ] "swapwindow, l"
        ++ helpers.bindsWithSameDispatcher [ " SHIFT, RIGHT" ", N" ] "swapwindow, r"
        ++ helpers.bindsWithSameDispatcher [ " SHIFT, UP" ", C" ] "swapwindow, u"
        ++ helpers.bindsWithSameDispatcher [ " SHIFT, DOWN" ", T" ] "swapwindow, d";

    ## Cycles the master window in the master layout
    cycleMaster = [ ", S, layoutmsg, rollnext" ];

    ## Moves or resizes windows with the mouse
    moveWindow = [ ", mouse:272, movewindow" ];
    resizeWindow = [ ", mouse:273, resizewindow" ];
}
