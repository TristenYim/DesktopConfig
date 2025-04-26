# Hypridle is Hyprland's idle management daemon
# Used for putting the computer "to sleep" automatically

# See https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/ for more info

{ config, lib, ... }: {
    options.apeiron = {
        hypridle.enable = lib.mkEnableOption "hypridle";
    };
 
    config = lib.mkIf config.apeiron.hypridle.enable 
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
                        on-timeout = "hyprctl dispatch dpms off & killall slack & killall Discord";
                        on-resume = "hyprctl dispatch dpms on";
                    }
                ];
            };
        };
    };
}
