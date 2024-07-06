{ config, pkgs, lib, ... }: {

    # Set a toggle to enable kitty
    options = {
        kitty-home.enable = lib.mkEnableOption "Enables kitty with Home Manager";
    };
 
    config = lib.mkIf config.kitty-home.enable 
    {
        programs.kitty = {
            enable = true;
            settings = {
                font_family = "jetbrains mono nerd font";
                font_size = "15";
                bold_font = "auto";
                italic_font = "auto";
                bold_italic_font = "auto";
                mouse_hide_wait = "2.0";
                cursor_shape = "block";
                url_color = "#0087bd";
                url_style = "dotted";
                confirm_os_window_close = 0;
                background_opacity = "0.95";
            };
        };
    };
}
