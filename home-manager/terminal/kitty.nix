{ config, pkgs, lib, ... }: 

# Import the nixGL wrapper
let nixGLWrap = import ../nixGL/nixGLWrapper.nix { 
    inherit config pkgs; 
};
in {
    # Set a toggle to enable kitty
    options = {
        kitty-home.enable = lib.mkEnableOption "Enables kitty with Home Manager";
    };
 
    config = lib.mkIf config.kitty-home.enable 
    {
        programs.kitty = {
            enable = true;
            package = lib.mkDefault "(nixGLWrap pkgs.kitty)";
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
                background_opacity = "1.0";
            };
            extraConfig = 
                "symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d4,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b1,U+e700-U+e7c5,U+f000-U+f2e0,U+f300-U+f372,U+f400-U+f532,U+f0001-U+f1af0 Symbols Nerd Font Mono";
        };
    };
}
