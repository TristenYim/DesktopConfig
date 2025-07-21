{ config, lib, toHyprConf }: {
    allBinds = lib.mapAttrsToList (name: value: toHyprConf value.keys ("exec, uwsm app -- " + value.action)) config.apeiron.desktop.keybinds.launchers; 
}
