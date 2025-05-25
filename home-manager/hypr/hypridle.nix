# Hypridle is Hyprland's idle management daemon
# Used for putting the computer "to sleep" automatically

# See https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/ for more info

{ config, lib, ... }: {
    options.apeiron.services = {
        hypridle.enable = lib.mkEnableOption "hypridle";
    };
 
    config = lib.mkIf config.apeiron.services.hypridle.enable 
    {
        services.hypridle = {
            enable = true;
            settings = {
                general = {
                    lock_cmd = "pidof swaylock || swaylock";
                    before_sleep_cmd = "loginctl lock-session";
                    after_sleep_cmd = "hyprctl dispatch dpms on${if config.apeiron.services.openrgb.enable then " & openrgb --profile latest" else ""}";
                };
                listener = [
                    {
                        timeout = 300;
                        on-timeout = "loginctl lock-session";
                    }
                    {
                        timeout = 600;
                        on-timeout = "killall -SIGSTOP slack & killall -SIGSTOP Discord & hyprctl dispatch dpms off${if config.apeiron.services.openrgb.enable then " & (openrgb --save-profile latest && openrgb --profile alloff)" else ""}";
                        on-resume = "killall -SIGCONT slack & killall -SIGCONT Discord & hyprctl dispatch dpms on${if config.apeiron.services.openrgb.enable then " & openrgb --profile latest" else ""}";
                    }
                ];
            };
        };
    };
}
