{ helpers }: rec

{
    allBinds = jumpTo ++ moveWindowTo ++ forAll ++ specialAll ++ scroll;

    # Moves (the active) window to one of the main workspaces
    jumpTo = helpers.bindForEachWorkspaceSelf "" "workspace";
    moveWindowTo = helpers.bindForEachWorkspaceSelf " SHIFT" "movetoworkspace";

    # Jumps to workspaces with special uses
    forAll = forChat ++ forMail;

    forChat = [ ", F1, workspace, name:CHAT" ];
    forMail = [ ", F2, workspace, name:MAIL" ];

    # Special workspaces
    specialAll = specialBtop ++ specialCider ++ specialConfig;

    specialBtop = [ ", B, togglespecialworkspace, BTOP" ];
    specialCider = [ ", P, togglespecialworkspace, CIDER" ];
    specialConfig = [ ", M, togglespecialworkspace, CONFIG" ];

    # Scrolls between workspaces
    scroll = [ ", mouse_up, workspace, e-1" ", mouse_down, workspace, e+1" ];
}
