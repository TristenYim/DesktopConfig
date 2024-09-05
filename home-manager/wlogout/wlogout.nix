{ config, pkgs, lib, ... }: {

    # Set a toggle to enable wlogout
    options = {
        wlogout-home.enable = lib.mkEnableOption "Enables wlogout with Home Manager";
    };
 
    config = lib.mkIf config.wlogout-home.enable 
    {
        home.file = {
            ".config/wlogout/catppuccin.css" = {
                source = config.lib.file.mkOutOfStoreSymlink ../resources/catppuccin.css;
            };
            ".config/wlogout/assets" = {
                source = config.lib.file.mkOutOfStoreSymlink ./assets;
                recursive = true;
            };
        };

        programs.wlogout = {
             enable = true;
             style = ./style.css;

             # See https://github.com/ArtsyMacav/wlogout#config for more
             layout = [
                 {
                     label = "lock";
                     action = "swaylock";
                     text = "Lock";
                 }

                 {
                     label = "hibernate";
                     action = "systemctl hibernate";
                     text = "Hibernate";
                 }

                 {
                     label = "logout";
                     action = "hyprctl dispatch exit 0";
                     text = "Logout";
                 }

                 {
                     label = "shutdown";
                     action = "systemctl poweroff";
                     text = "Shutdown";
                 }

                 {
                     label = "suspend";
                     action = "systemctl suspend";
                     text = "Suspend";
                 }

                 {
                     label = "reboot";
                     action = "systemctl reboot";
                     text = "Reboot";
                 }
            ];
        };
    };
}
