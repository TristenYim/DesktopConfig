{ config, lib, ... }: {

    # Define the CSS style in a separate file
    imports = [ 
        ./style.nix 
    ];

    # Set a toggle to enable wlogout
    options = {
        wlogout-home.enable = lib.mkEnableOption "Enables wlogout with Home Manager";
    };
 
    config = lib.mkIf config.wlogout-home.enable 
    {
        home.file = {
            ".config/wlogout/assets" = {
                source = config.lib.file.mkOutOfStoreSymlink ./assets;
                recursive = true;
            };
        };

        programs.wlogout = {
             enable = true;

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
