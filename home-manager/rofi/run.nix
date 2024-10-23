{ config, lib, ... }:
let
    catppuccin = (import ../theme/catppuccin-colors.nix);
in
{
    config = lib.mkIf config.rofi-home.enable 
    {
        home.file.".config/rofi/run.rasi" = {
            text = ''
                window {
                    border: 2px;
                    border-radius: 20px ;
                    background-color: ${catppuccin.base}80;
                    border-color: ${catppuccin.sky};
                    font: "Merienda 15";
                    transparency: "real";
                    width: 600;
                    location: center;
                    anchor: center;
                }

                mainbox {
                    background-color: transparent;
                    spacing: 0;
                }

                inputbar {
                    padding: 8px;
                    background-color: ${catppuccin.surface0}99;
                    border: 8px;
                    border-radius: 20px;
                    text-color: ${catppuccin.text};
                    children: [ "icon-keyboard", "entry", "case-indicator" ];
                }

                icon-keyboard {
                    margin: 0 12 0 0;
                    background-color: transparent;
                    size: 1.0em;
                    filename: "search";
                    expand: false;
                }

                entry {
                    background-color: transparent;
                    text-color: ${catppuccin.blue};
                    placeholder: "Run...";
                    placeholder-color: ${catppuccin.subtext0};
                    cursor-color: ${catppuccin.subtext0};
                }

                case-indicator {
                    background-color: transparent;
                    text-color: inherit;
                }

                listview {
                    background-color: transparent;
                    padding: 8px;
                    dynamic: false;
                    scrollbar: true;
                    lines: 6;
                }

                scrollbar {
                    margin: 0 0 0 4;
                    background-color: transparent;
                    handle-color: ${catppuccin.sapphire};
                    handle-width: 2;
                }

                element {
                    background-color: transparent;
                    padding: 5px ;
                    text-color: ${catppuccin.text};
                    children: [element-icon, element-text];
                }

                element selected {
                    border-radius: 16px;
                    background-color: ${catppuccin.blue};
                }

                element-text {
                    background-color: transparent;
                    text-color: inherit;
                }

                element-icon {
                    margin: 0 6 0 6;
                    background-color: inherit;
                    size: 1.20em;
                }

                mode-switcher {
                    border: 0 8 0 8;
                    border-radius: 16;
                    spacing: 4;
                    border-color: ${catppuccin.mantle};
                    background-color: ${catppuccin.mantle};
                }

                button {
                    text-color: ${catppuccin.subtext0};
                    background-color: ${catppuccin.mantle};
                }

                button selected {
                    text-color: ${catppuccin.blue};
                }
            '';
        };
    };
}
