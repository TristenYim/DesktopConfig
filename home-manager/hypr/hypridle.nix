# Hypridle is Hyprland's idle management daemon
# Used for putting the computer "to sleep" automatically

# See https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/ for more info

{ config, lib, ... }: {
    options = {
        hypridle-home.enable = lib.mkEnableOption "Enables hypridle with Home Manager";
    };
 
    config = lib.mkIf config.hypridle-home.enable 
    {
        services.hypridle = {
            enable = true;
            settings = {
                general = {
                    lock_cmd = "swaylock";
                    before_sleep_cmd = "loginctl lock-session";
                    after_sleep_cmd = "hyprctl dispatch dpms on";
                };
                listener = [
                    {
                        timeout = 300;
                        on-timeout = "swaylock";
                    }
                    {
                        timeout = 600;
                        on-timeout = "hyprctl dispatch dpms off";
                        on-resume = "hyprctl dispatch dpms on";
                    }
                ];
            };
        };
    };
}
