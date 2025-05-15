{ helpers }: rec

{
    allBinds = jumpTo ++ moveWindowTo ++ switchMonitor ++ swapMonitorWorkspaces ++ forAll ++ specialAll ++ scroll;

    # Moves (the active) window to one of the main workspaces
    jumpTo = helpers.bindForEachWorkspaceSelf "" "split:workspace";
    moveWindowTo = helpers.bindForEachWorkspaceSelf " SHIFT" "split:movetoworkspace";

    # Multi-monitor management
    switchMonitor = [ ", GRAVE, focusmonitor, +1" ];
    swapMonitorWorkspaces = [ "SHIFT, GRAVE, split:swapactiveworkspaces, current +1" ];

    # Jumps to workspaces with special uses
    forAll = forChat ++ forMail;

    forChat = [ ", F1, workspace, name:CHAT" ];
    forMail = [ ", F2, workspace, name:MAIL" ];

    # Special workspaces
    specialAll = specialBtop ++ specialCider ++ specialConfig ++ specialAgenda;

    specialBtop = [ ", B, togglespecialworkspace, BTOP" ];
    specialCider = [ ", P, togglespecialworkspace, CIDER" ];
    specialConfig = [ ", M, togglespecialworkspace, CONFIG" ];
    specialAgenda = [ ", W, togglespecialworkspace, AGENDA" ];

    # Scrolls between workspaces
    scroll = [ ", mouse_up, split:workspace, e-1" ", mouse_down, workspace, e+1" ];
}
