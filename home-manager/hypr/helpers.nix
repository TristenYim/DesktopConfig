{ lib }: rec {
    # Creates a list binds for each workspace where the argument for each
    # dispatcher is the workspace number.
    bindForEachWorkspaceSelf = prefix: dispatcher:
    [
        "${prefix}, 1, ${dispatcher}, 1" 
        "${prefix}, 2, ${dispatcher}, 2" 
        "${prefix}, 3, ${dispatcher}, 3" 
        "${prefix}, 4, ${dispatcher}, 4" 
        "${prefix}, 5, ${dispatcher}, 5" 
        "${prefix}, 6, ${dispatcher}, 6" 
        "${prefix}, 7, ${dispatcher}, 7" 
        "${prefix}, 8, ${dispatcher}, 8" 
        "${prefix}, 9, ${dispatcher}, 9" 
        "${prefix}, 0, ${dispatcher}, 10" 
    ];

    # Creates a bind for each workspace where the dispatcher has no 
    # additional args.
    bindForEachWorkspace = prefix: dispatcher:
    [
        "${prefix}, 1, ${dispatcher}" 
        "${prefix}, 2, ${dispatcher}" 
        "${prefix}, 3, ${dispatcher}" 
        "${prefix}, 4, ${dispatcher}" 
        "${prefix}, 5, ${dispatcher}" 
        "${prefix}, 6, ${dispatcher}" 
        "${prefix}, 7, ${dispatcher}" 
        "${prefix}, 8, ${dispatcher}" 
        "${prefix}, 9, ${dispatcher}" 
        "${prefix}, 0, ${dispatcher}" 
    ];
 
    # Creates many binds which share a dispatcher.
    bindsWithSameDispatcher = keyList: dispatcher: 
        lib.lists.forEach keyList (keybind: keybind + ", " + dispatcher);

    # Creates a bind with multiple dispatchers.
    bindWithManyDispatchers = key: dispatcherList: 
        lib.lists.forEach dispatcherList (dispatcher: key + ", " + dispatcher);

    # Appends super to a list of keybinds.
    prependSuper = keybindList:
        lib.lists.forEach keybindList (keybind: "SUPER" + keybind);

    # This converts a hyprland setting in Nix list form to its string form.
    # Mainly useful for writing submaps, which must be declared in 
    # wayland.windowManager.hyprland.extraConfig.
    listToString = name: optionList: 
        lib.lists.foldr
            (a: b: a + "\n" + b) 
            "" 
            (lib.lists.forEach optionList (i: name + "=" + i));
   
    # Creates a submap of the given name with the keybinds and mousebinds
    # defined in a list, similar to how it's normally done in nix code.
    makeSubmap = name: bindList: bindmList:
        ''
            submap = ${name}

        ''
        + listToString "bind" bindList
        + listToString "bindm" bindmList
        + ''

            submap = reset
        '';
}
