{ config, pkgs, lib, ... }: {

    # Set a toggle to enable Waybar
    options = {
        waybar-home.enable = lib.mkEnableOption "Enables Waybar with Home Manager";
    };
 
    config = lib.mkIf config.waybar-home.enable 
    {
        programs.waybar = {
            enable = true;
            style = ./style.css;
            settings =
            [   
                {
                    layer = "top";
                    position = "top";
                    mod = "dock";
                    exclusive = true;
                    passthrough = false;
                    gtk-layer-shell = true;
                    height = 20;
                    reload_style_on_change = true;
                    modules-left = [
                        "custom/power_btn"
                        "custom/lock_screen"
                        "idle_inhibitor"
                      # "mpris"
                        "hyprland/window"
                        "battery"
                        "backlight"
                        "tray"
                    ];
                    modules-center = [
                        "hyprland/workspaces"
                        "clock"
                        "custom/updates"
                    ];
                    modules-right = [
                        "pulseaudio"
                        "pulseaudio#microphone"
                        "cpu"
                        "memory"
                        "temperature"
                        "network"
                    ];

                    "custom/power_btn" = {
                        format = "";
                        on-click = "sh -c '(wlogout --protocol layer-shell)' & disown";
                        tooltip-format = "Logout";
                    };

                    "custom/lock_screen" = {
                        format = "󰷛";
                        on-click = "sh -c '(swaylock)' & disown";
                        tooltip-format = "Lock";
                    };

                    "idle_inhibitor" = {
                        format = "{icon}";
                        format-icons = {
                            activated = "󰛐";
                            deactivated = "󰛑";
                        };
                        tooltip = true;
                    };

                    "mpris" = {
                        format = "DEFAULT: {player_icon} {dynamic}";
                        format-paused = "DEFAULT: {status_icon} <i>{dynamic}</i>";
                        player-icons = {
                            default = "▶";
                            mpv = "🎵";
                        };
                        status-icons = {
                            paused = "⏸";
                        };
                    };

                    "hyprland/window" = {
                        format = "{class}/{title}";
                        max-length = 30;
                        tooltip-format = "{class}/{title} {initialClass}/{initialTitle}";
                        separate-outputs = true;
                    };

                    "backlight" = {
                        format = "{icon}{percent}%";
                        format-icons = [" " " " " " "󰃝 " "󰃞 " "󰃟 " "󰃠 "];
                        tooltip-format = "backlight {percent}%";
                        icon-size = 10;
                        on-scroll-up = "$HOME/.config/waybar/scripts/Brightness.sh --inc";
                        on-scroll-down = "$HOME/.config/waybar/scripts/Brightness.sh --dec";
                        smooth-scrolling-threshold = 1;
                    };

                    "battery" = {
                        design-capacity = false;
                        states = {
                            good = 95;
                            warning = 30;
                            critical = 15;
                        };
                        format = "{icon} {capacity}%";
                        format-charging = "{capacity}%";
                        format-plugged = "󱘖{capacity}%";
                        format-alt-click = "click";
                        format-full = "{icon} Full";
                        format-alt = "{icon} {time}";
                        format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
                        format-time = "{H}h {M}min";
                        tooltip = true;
                        tooltip-format = "{timeTo} {power}";
                    };

                    "tray" = {
                        icon-size = 16;
                        spacing = 10;
                    };

                    "custom/updates" = {
                        format = "{}";
                        exec = "$HOME/.config/waybar/scripts/update-sys";
                        on-click = "$HOME/.config/waybar/scripts/update-sys update";
                        interval = 300;
                        tooltip = true;
                    };

                    "hyprland/workspaces" = {
                        active-only = false;
                        all-outputs = false;
                        format = "{icon}";
                        on-click = "activate";
                        format-icons = {
                            "1" = "I";
                            "2" = "II";
                            "3" = "III";
                            "4" = "IV";
                            "5" = "V";
                            "6" = "VI";
                            "7" = "VII";
                            "8" = "VIII";
                            "9" = "IX";
                            "10" = "X";
                            "Chat" = "";
                            "OVERVIEW" = "       ";
                            "default" = "uwu";
                        };
                    };

                    "clock" = {
                        format = "{:%H:%M, %a %d %b}";
                        tooltip-format = "<tt><small>{calendar}</small></tt>";
                        calendar = {
                            mode = "year";
                            mode-mon-col = 3;
                        };
                    };

                    "pulseaudio" = {
                        format = "{icon}  {volume}%";
                        format-muted = "";
                        on-click = "$HOME/.config/waybar/scripts/volume --toggle";
                        on-click-right = "pavucontrol --tab 3";
                        on-scroll-up = "$HOME/.config/waybar/scripts/volume --inc";
                        on-scroll-down = "$HOME/.config/waybar/scripts/volume --dec";
                        scroll-step = 1;
                        format-icons = {
                            headphone = "";
                            hands-free = "";
                            headset = "";
                            phone = "";
                            portable = "";
                            car = "";
                            default = ["" "" " "];
                        };
                        tooltip = true;
                        tooltip-format = "{icon}  {volume}%";
                    };

                    "pulseaudio#microphone" = {
                        format = "{format_source}";
                        format-source = " {volume}%";
                        format-source-muted = " ";
                        on-click = "$HOME/.config/waybar/scripts/volume --toggle-mic";
                        on-click-right = "pavucontrol --tab 4";
                        on-scroll-up = "$HOME/.config/waybar/scripts/volume --mic-inc";
                        on-scroll-down = "$HOME/.config/waybar/scripts/volume --mic-dec";
                        scroll-step = 1;
                        tooltip = true;
                        tooltip-format = " {volume}%";
                    };

                    "cpu" = {
                        interval = 10;
                        format = "  {usage}%";
                        max-length = 10;
                        format-alt-click = "click-right";
                        format-alt = "";
                        on-click = "kitty --start-as=fullscreen --title btop sh -c 'btop'";
                    };

                    "memory" = {
                        interval = 10;
                        format = " {used:0.1f} GiB";
                        max-length = 10;
                        format-alt-click = "click-right";
                        format-alt = " {percentage}%";
                        on-click = "kitty --start-as=fullscreen --title btop sh -c 'btop'";
                    };

                    "temperature" = {
                      # thermal-zone = 2;
                      # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
                        critical-threshold = 80;
                        format-critical = "{temperatureC}°C {icon}";
                        format = "{icon} {temperatureC}°C";
                        format-icons = ["" "" ""];
                        on-click = "kitty --start-as=fullscreen --title btop sh -c 'btop'";
                    };

                    "network" = {
                        format-ethernet = " {bandwidthTotalBits}";
                        format-wifi = "󰖩 {bandwidthTotalBits}";
                        format-disconnected = "";
                        interval = 10;
                        max-length = 10;
                        tooltip-format-ethernet = "IP: {ipaddr},  {bandwidthUpBits},  {bandwidthDownBits}, {ifname}";
                        tooltip-format-wifi = "IP: {ipaddr},  {bandwidthUpBits},  {bandwidthDownBits}, {ifname}";
                        on-click = "nm-connection-editor";
                    };
                }
            ];
        };

        home.file = {
            ".config/waybar/catppuccin.css" = {
                source = config.lib.file.mkOutOfStoreSymlink ../resources/catppuccin.css;
            };
            ".config/waybar/scripts" = {
                source = config.lib.file.mkOutOfStoreSymlink ./scripts;
                recursive = true;
            };
        };
    };
}
