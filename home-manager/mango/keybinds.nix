# All MangoWC keybinds

# See https://github.com/DreamMaoMao/mangowc/wiki#key-bindings
# for more information on configuring.

{ config, pkgs, lib, myLib, ... }: 
let
    cfg = config.apeiron.desktop.compositors.settings.keybinds;

    # Generates a single keybind from the compositor-agnostic keybind format
    mkBind = keys: action: 
        let 
            modList = [ "SUPER" "SHIFT" "ALT" ];
            convertList = modPrefix: actionPrefix: i:
                let
                    e = builtins.elemAt keys i;
                in if ! builtins.elem e modList then "${actionPrefix},${e}," else "${modPrefix}${e}" + convertList "+" "" (i + 1);
        in (convertList "" "NONE" 0) + action;

    # Generates one or more binds sharing a dispatcher from the compositor-agnostic keybind format
    mkBinds = 
    keys: action:
        if builtins.isString (builtins.elemAt keys 0)
        then mkBind keys action |> lib.singleton
        else builtins.map (keyList: mkBind keyList action) keys;

    # Used for generating a keybind action based on a default app
    actionFromApp = let 
        # spawn = "spawn,uwsm app -- "; 
        spawn = "spawn,"; 
        in app: 
        if ! builtins.hasAttr "flags" app 
        then spawn + lib.getExe app 
        else spawn + lib.getExe app.package + " " + app.flags;

    # Creates a keybind with a dispatcher associated with each numbered tag
    bindForEachTag = prefix: dispatcher:
        [
            [ (prefix ++ [ "1" ]) "${dispatcher},1" ]
            [ (prefix ++ [ "2" ]) "${dispatcher},2" ]
            [ (prefix ++ [ "3" ]) "${dispatcher},3" ]
            [ (prefix ++ [ "4" ]) "${dispatcher},4" ]
            [ (prefix ++ [ "5" ]) "${dispatcher},5" ]
            [ (prefix ++ [ "6" ]) "${dispatcher},6" ]
            [ (prefix ++ [ "F1" ]) "${dispatcher},7" ] # Scroller scratchpads are bound to the F-keys
            [ (prefix ++ [ "F2" ]) "${dispatcher},8" ]
        ] |> myLib.mapCalls mkBinds |> builtins.concatLists;
in
{
    config.wayland.windowManager.mango.configAttrs = lib.mkIf config.apeiron.desktop.compositors.mango.enable {
        mousebind = [
            [ [ "SUPER" "btn_left" ] "moveresize,curmove" ]
            [ [ "SUPER" "btn_right" ] "moveresize,curresize" ]
            [ [ "btn_left" ] "toggleoverview,-1" ] # Exit overview
        ] |> myLib.mapCalls mkBinds |> builtins.concatLists;

        bind = 
            builtins.map (bind: mkBind bind.keys (actionFromApp bind.app)) cfg.launchers
            ++ bindForEachTag [ "SUPER" ] "view"
            ++ bindForEachTag [ "SUPER" "SHIFT" ] "tag"
            ++ ([
                [ [ "SUPER" "F3" ] "spawn_on_empty,${pkgs.writeShellScript "mango-chat" "slack & signal-desktop & flatpak run --branch=stable --arch=x86_64 com.discordapp.Discord"},9" ]

                # Import compositor-agnostic keybinds
                [ cfg.scratchpads.agenda "toggle_named_scratchpad,scratchpad-agenda,none,1,1,kitty --app-id=scratchpad-agenda nvim ${config.programs.nixvim.plugins.orgmode.settings.org_agenda_files} +\"Org agenda a\"" ]
                [ cfg.scratchpads.btop "toggle_named_scratchpad,scratchpad-btop,none,1,1,kitty --app-id=scratchpad-btop btop" ]
                [ cfg.scratchpads.cider "toggle_named_scratchpad,scratchpad-cider,none,1,1,cider" ]
                [ cfg.scratchpads.config "toggle_named_scratchpad,scratchpad-config,none,1,1,kitty --app-id=scratchpad-config nvim ${config.home.sessionVariables.FLAKE}/source" ]
                [ cfg.misc.cycleLayouts "switch_layout," ]
                [ cfg.misc.reload "reload_config," ]
                [ cfg.misc.quit "quit," ]
                [ cfg.misc.toggleOverview "toggleoverview," ]
                [ cfg.windowManagement.cycleMasterFromTop "zoom," ]
                [ cfg.windowManagement.focusAcrossMonitors "focusmon,right" ]
                [ cfg.windowManagement.focusLeft "focusdir,left" ]
                [ cfg.windowManagement.focusRight "focusdir,right" ]
                [ cfg.windowManagement.focusUp "focusdir,up" ]
                [ cfg.windowManagement.focusDown "focusdir,down" ]
                [ cfg.windowManagement.kill "killclient," ]
                [ cfg.windowManagement.swapAcrossMonitors "tagmon,right" ]
                [ cfg.windowManagement.swapLeft "exchange_client,left" ]
                [ cfg.windowManagement.swapRight "exchange_client,right" ]
                [ cfg.windowManagement.swapUp "exchange_client,up" ]
                [ cfg.windowManagement.swapDown "exchange_client,down" ]
                [ cfg.windowManagement.toggleFloat "togglefloating," ]
            ] |> myLib.mapCalls mkBinds |> builtins.concatLists);
    };
}
