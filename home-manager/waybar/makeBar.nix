# This lambda makes a bar with a custom name to the passed output.
# This is used for customizing how the bar looks per monitor.
name: display: {
    layer = "top";
    position = "top";
    mod = "dock";
    exclusive = true;
    passthrough = false;
    gtk-layer-shell = true;
    reload_style_on_change = true;
    name = name;
    output = display;

    modules-left = [
        "group/lock#${name}"
        # "hyprland/window"
        "mpris#${name}"
    ];

    modules-center = [
        "hyprland/workspaces#${name}"
        "clock#${name}"
        "group/config#${name}"
    ];

    modules-right = [
        "group/trayicons#${name}"
        "group/audio#${name}"
        "group/hardware#${name}"
    ];

    "group/lock#${name}" = {
        orientation = "horizontal";
        modules = [
            "custom/power_btn#${name}"
            "custom/lock_screen#${name}"
            "idle_inhibitor#${name}"
        ];
    };

    "group/config#${name}" = {
        orientation = "horizontal";
        modules = [
            "custom/nix_config#${name}"
            "custom/updates#${name}"
        ];
    };

    "group/trayicons#${name}" = {
        orientation = "horizontal";
        modules = [
            "tray#${name}"
            "battery#${name}"
            "backlight#${name}"
        ];
    };

    "group/audio#${name}" = {
        orientation = "horizontal";
        modules = [
            "pulseaudio#${name}"
            "pulseaudio#${name}.microphone"
        ];
    };

    "group/hardware#${name}" = {
        orientation = "horizontal";
        modules = [
            "cpu#${name}"
            "memory#${name}"
            # "temperature#${name}"
            "network#${name}"
        ];
    };

    "custom/power_btn#${name}" = {
        format = "";
        on-click = "sh -c '(wlogout --protocol layer-shell)' & disown";
        tooltip-format = "Logout";
    };

    "custom/lock_screen#${name}" = {
        format = "󰷛";
        on-click = "sh -c '(swaylock)' & disown";
        tooltip-format = "Lock";
    };

    "idle_inhibitor#${name}" = {
        format = "{icon}";
        format-icons = {
            activated = "󰛐";
            deactivated = "󰛑";
        };
        tooltip = true;
    };

    "mpris#${name}" = {
        interval = 1;
        format = "{player_icon} [{position}/{length}] {title} | {artist}";
        format-paused = "{status_icon} [{position}/{length}] {title} | {artist}";
        player-icons = {
            default = "▶ ";
            cider = " ";
        };
        status-icons = {
            paused = "⏸ ";
        };
        title-len = 25;
        artist-len = 15;
    };

    "hyprland/window#${name}" = {
        format = "{class}/{title}";
        max-length = 30;
        tooltip-format = "{class}/{title} {initialClass}/{initialTitle}";
        separate-outputs = true;
    };

    "custom/nix_config#${name}" = {
        format = "";
        on-click = "hyprctl dispatch togglespecialworkspace CONFIG";
        tooltip-format = "Config";
    };

    "custom/updates#${name}" = {
        format = "{}";
        exec = "$HOME/.config/waybar/scripts/update-sys";
        on-click = "$HOME/.config/waybar/scripts/update-sys update";
        interval = 300;
        tooltip = true;
    };

    "hyprland/workspaces#${name}" = {
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
            "CHAT" = "󰭻";
            "MAIL" = " ";
            "OVERVIEW" = "     ";
            "default" = "uwu";
        };
    };

    "clock#${name}" = {
        format = "{:%H:%M, %a %d %b}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
            mode = "year";
            mode-mon-col = 3;
        };
    };

    "backlight#${name}" = {
        format = "{icon}{percent}%";
        format-icons = [" " " " " " "󰃝 " "󰃞 " "󰃟 " "󰃠 "];
        tooltip-format = "backlight {percent}%";
        icon-size = 10;
        on-scroll-up = "$HOME/.config/waybar/scripts/Brightness.sh --inc";
        on-scroll-down = "$HOME/.config/waybar/scripts/Brightness.sh --dec";
        smooth-scrolling-threshold = 1;
    };

    "battery#${name}" = {
        design-capacity = false;
        states = {
            good = 95;
            warning = 30;
            critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-alt-click = "click";
        format-full = "{icon} Full";
        format-alt = "{icon} {time}";
        format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        format-time = "{H}h {M}min";
        tooltip = true;
        tooltip-format = "{timeTo} {power}";
    };

    "tray#${name}" = {
        icon-size = 16;
        spacing = 10;
    };

    "pulseaudio#${name}" = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 ";
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
            default = ["󰕿" "󰖀" "󰕾 "];
        };
        tooltip = true;
        tooltip-format = "{icon} {desc}";
    };

    "pulseaudio#${name}.microphone" = {
        format = "{format_source}";
        format-source = " {volume}% ";
        format-source-muted = "  ";
        on-click = "$HOME/.config/waybar/scripts/volume --toggle-mic";
        on-click-right = "pavucontrol --tab 4";
        on-scroll-up = "$HOME/.config/waybar/scripts/volume --mic-inc";
        on-scroll-down = "$HOME/.config/waybar/scripts/volume --mic-dec";
        scroll-step = 1;
        tooltip = true;
        tooltip-format = " {desc}";
    };

    "cpu#${name}" = {
        interval = 5;
        format = "  {usage}%";
        max-length = 10;
        format-alt-click = "click-right";
        format-alt = "  {avg_frequency} GHz";
        on-click = "hyprctl dispatch togglespecialworkspace BTOP";
    };

    "memory#${name}" = {
        interval = 5;
        format = "   {used:0.1f} GiB";
        max-length = 10;
        format-alt-click = "click-right";
        format-alt = "   {percentage}%";
        on-click = "hyprctl dispatch togglespecialworkspace BTOP";
    };

    "temperature#${name}" = {
        # thermal-zone = 2;
        # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
        critical-threshold = 80;
        format-critical = "{temperatureC}°C {icon}";
        format = "{icon} {temperatureC}°C";
        format-icons = ["" "" ""];
        on-click = "hyprctl dispatch togglespecialworkspace BTOP";
    };

    "network#${name}" = {
        format-ethernet = "  {bandwidthTotalBits}";
        format-wifi = "󰖩 {bandwidthTotalBits}";
        format-disconnected = "";
        interval = 10;
        max-length = 10;
        tooltip-format-ethernet = "IP: {ipaddr},  {bandwidthUpBits},  {bandwidthDownBits}, {ifname}";
        tooltip-format-wifi = "IP: {ipaddr},  {bandwidthUpBits},  {bandwidthDownBits}, {ifname}";
        on-click = "nm-connection-editor";
    };
}
