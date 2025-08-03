# This lambda makes a bar with a custom name to the passed output.
# This is used for customizing how the bar looks per monitor.
name: display: {
    layer = "top";
    position = "top";
    passthrough = false;
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
            "idle_inhibitor#${name}"
        ];
    };

    "group/config#${name}" = {
        orientation = "horizontal";
        modules = [
            "custom/nix_config#${name}"
        ];
    };

    "group/trayicons#${name}" = {
        orientation = "horizontal";
        modules = [
            "tray#${name}"
            "battery#${name}"
            "backlight#${name}"
            "network#${name}"
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
        ];
    };

    "custom/power_btn#${name}" = {
        format = "";
        on-click = "sh -c '(wlogout --protocol layer-shell)' & disown";
        tooltip = false;
    };

    "idle_inhibitor#${name}" = {
        format = "{icon}";
        format-icons = {
            activated = "󰛐";
            deactivated = "󰛑";
        };
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
        tooltip = false;
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

            ## Workspaces 11-20 are used by hyprsplit
            "11" = "I";
            "12" = "II";
            "13" = "III";
            "14" = "IV";
            "15" = "V";
            "16" = "VI";
            "17" = "VII";
            "18" = "VIII";
            "19" = "IX";
            "20" = "X";
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
        tooltip = false;
        icon-size = 10;
        on-scroll-up = "brightnessctl set +2%";
        on-scroll-down = "brightnessctl set 2%-";
    };

    "battery#${name}" = {
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-alt-click = "click";
        format-full = "{icon} Full";
        format-alt = "{icon} {power:0.2f} W";
        format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        format-time = "{H}h {M}min";
    };

    "network#${name}" = {
        format-ethernet = " ";
        format-wifi = "{icon}";
        format-disconnected = " ";
        format-icons = ["󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 "];
        tooltip-format-ethernet = "  {bandwidthUpBits},   {bandwidthDownBits}, IP: {ipaddr}";
        tooltip-format-wifi = "  {bandwidthUpBits},   {bandwidthDownBits}, IP: {ipaddr}";
        on-click = "nm-connection-editor";
    };

    "tray#${name}" = {
        icon-size = 16;
        spacing = 10;
    };

    "pulseaudio#${name}" = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 ";
        on-click = "pamixer --toggle-mute";
        on-click-right = "pavucontrol --tab 3";
        on-scroll-up = "pamixer --increase 1";
        on-scroll-down = "pamixer --decrease 1";
        format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["󰕿" "󰖀" "󰕾 "];
        };
        tooltip-format = "{icon} {desc}";
    };

    "pulseaudio#${name}.microphone" = {
        format = "{format_source}";
        format-source = " {volume}% ";
        format-source-muted = "  ";
        on-click = "pamixer --default-source --toggle-mute";
        on-click-right = "pavucontrol --tab 4";
        on-scroll-up = "pamixer --default-source --increase 1";
        on-scroll-down = "pamixer --default-source --decrease 1";
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
}
