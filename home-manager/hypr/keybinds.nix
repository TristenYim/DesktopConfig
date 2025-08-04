# All hyprland keybinds (except ones defined in plugins)

# See https://wiki.hyprland.org/Configuring/Binds/ for more info
{ config, lib, myLib, ... }: 
let
    cfg = config.apeiron.desktop.compositors.settings.keybinds;

    # Generates a single keybind from the compositor-agnostic keybind format
    mkBind = keys: action: 
        let 
            modList = [ "SUPER" "SHIFT" "ALT" ];
            convertList = separator: i:
                let
                    e = builtins.elemAt keys i;
                in if ! builtins.elem e modList then ", ${e}, " else " ${e}" + convertList "_" (i + 1);
        in (convertList "" 0) + action;

    # Generates one or more binds sharing a dispatcher from the compositor-agnostic keybind format
    mkBinds = 
    keys: action:
        if builtins.isString (builtins.elemAt keys 0)
        then mkBind keys action |> lib.singleton
        else builtins.map (keyList: mkBind keyList action) keys;

    # Used for generating a keybind action based on a default app
    actionFromApp = let 
        exec = "exec, uwsm app -- "; 
        in app: 
        if ! builtins.hasAttr "flags" app 
        then exec + lib.getExe app 
        else exec + lib.getExe app.package + " " + app.flags;

    # Creates a keybind with a dispatcher associated with each numbered workspace
    bindForEachWorkspace = prefix: dispatcher:
        [
            [ (prefix ++ [ "1" ]) "${dispatcher}, 1" ]
            [ (prefix ++ [ "2" ]) "${dispatcher}, 2" ]
            [ (prefix ++ [ "3" ]) "${dispatcher}, 3" ]
            [ (prefix ++ [ "4" ]) "${dispatcher}, 4" ]
            [ (prefix ++ [ "5" ]) "${dispatcher}, 5" ]
            [ (prefix ++ [ "6" ]) "${dispatcher}, 6" ]
            [ (prefix ++ [ "7" ]) "${dispatcher}, 7" ]
            [ (prefix ++ [ "8" ]) "${dispatcher}, 8" ]
            [ (prefix ++ [ "9" ]) "${dispatcher}, 9" ]
            [ (prefix ++ [ "0" ]) "${dispatcher}, 10" ]
        ] |> myLib.mapCalls mkBinds |> builtins.concatLists;

    # Creates a bind which cycles a variable associated with one or more options.
    # The cycler expression should be used to determine how the state changes.
    cycleOptionsDispatcher = cycler: option: variable: "execr, state=$(hyprctl getoption ${option} 2>&1 | grep -m1 \"\" | awk \'{ print $2}\') && ${cycler} && hyprctl keyword ${variable} $state";

    # Creates a bind which toggles a variable associated with one or more options.
    toggleOptionsDispatcher = cycleOptionsDispatcher "state=$(( ! \"\${state}\" ))";
in 
{
    config.wayland.windowManager.hyprland.settings = lib.mkIf config.apeiron.desktop.hyprland.enable 
    {
        bind = 
            builtins.map (bind: mkBind bind.keys (actionFromApp bind.app)) cfg.launchers
            ++ bindForEachWorkspace [ "SUPER" ] "split:workspace"
            ++ bindForEachWorkspace [ "SUPER" "SHIFT" ] "split:movetoworkspace"
            ++ ( [
                # Cycle layouts
                [ [ "SUPER" "L" ] (cycleOptionsDispatcher "if [[ $state == dwindle ]]; then state=master; elif [[ $state == master ]]; then state=dwindle; fi" "general:layout" "general:layout") ]

                # Toggle animations, blur, and shadows
                [ [ "SUPER" "V" ] (toggleOptionsDispatcher "animations:enabled" "\\$\"uglyAFModeDisabled\"") ]

                 # Scroll workspaces
                [ [ "SUPER" "mouse_up" ] "split:workspace, e-1" ]
                [ [ "SUPER" "mouse_down" ] "split:workspace, e+1" ]

                # Switch monitor focus
                [ [ "SUPER" "GRAVE" ] "focusmonitor, +1" ]

                # Swap monitor content
                [ [ "SUPER" "SHIFT" "GRAVE" ] "split:swapactiveworkspaces, current +1" ]

                # Jump to named workspaces
                [ [ "SUPER" "F1" ] "workspace, name:CHAT" ]
                [ [ "SUPER" "F2" ] "workspace, name:MAIL" ]

                # Import compositor-agnostic keybinds, see ../compositor-options.nix
                [ cfg.scratchpads.agenda "togglespecialworkspace, AGENDA" ]
                [ cfg.scratchpads.btop "togglespecialworkspace, BTOP" ]
                [ cfg.scratchpads.cider "togglespecialworkspace, CIDER" ]
                [ cfg.scratchpads.config "togglespecialworkspace, CONFIG" ]
                [ cfg.windowManagement.cycleMasterFromTop "layoutmsg, rollnext" ]
                [ cfg.windowManagement.focusLeft "movefocus, l" ]
                [ cfg.windowManagement.focusRight "movefocus, r" ]
                [ cfg.windowManagement.focusUp "movefocus, u" ]
                [ cfg.windowManagement.focusDown "movefocus, d" ]
                [ cfg.windowManagement.kill "killactive," ]
                [ cfg.windowManagement.swapLeft "swapwindow, l" ]
                [ cfg.windowManagement.swapRight "swapwindow, r" ]
                [ cfg.windowManagement.swapUp "swapwindow, u" ]
                [ cfg.windowManagement.swapDown "swapwindow, d" ]
                [ cfg.windowManagement.quit "exit," ]
                [ cfg.windowManagement.toggleFloat "togglefloating," ]
            ] |> myLib.mapCalls mkBinds |> builtins.concatLists);
    
        # Allows moving and resizing windows like in floating window managers when holding SUPER
        bindm = [ "SUPER, mouse:272, movewindow" "SUPER, mouse:273, resizewindow" ];
    };
}
