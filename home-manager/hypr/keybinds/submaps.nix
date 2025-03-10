{ helpers, workspaceBinds, windowBinds }:

{
    altL = {
        enter = [ ", ALT_L, submap, altl" ];
        config = helpers.makeSubmap
            "altl"
            (
                # Exit submap
                helpers.bindsWithSameDispatcher [ ", ALT_L" ", ENTER" ", SUPER_L" ] "submap, reset"

                ++ windowBinds.allBinds
                ++ workspaceBinds.jumpTo
                ++ workspaceBinds.moveWindowTo
                ++ workspaceBinds.forAll
                ++ workspaceBinds.scroll
            )
            ( windowBinds.allBindms );
    };
}
