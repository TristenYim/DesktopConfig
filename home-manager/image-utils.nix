{ config, pkgs, lib, ... }: {

    options = {
        feh-home.enable = lib.mkEnableOption "Enables feh";
        screenshot-home.enable = lib.mkEnableOption "Enables screenshotting in HyprDE with Home Manager";
    };

    config = lib.mkMerge 
    [
        # feh, image viewer
        ( lib.mkIf config.feh-home.enable {
            home = {
                packages = [ 
                    pkgs.feh 
                ];
                file.".config/feh/themes" = {
                    enable = true;
                    text = ''
                        default --scale-down
                    '';
                };
            };
        })

        # Screenshot utils
        (lib.mkIf config.screenshot-home.enable {
            home = {
                packages = [
                    pkgs.grim # The tool that actually captures the screen
                    pkgs.slurp # The tool that allows me to select a region of my screen
                    pkgs.swappy # The tool that allows me to edit the final image
                ];
                file.".config/swappy/config" = {
                    enable = true;
                    text = ''
                        [Default]
                        save_dir=$HOME/Pictures/Screenshots
                        save_filename_format=swappy-%Y%m%d-%H%M%S.png
                        show_panel=false
                        line_size=5
                        text_size=20
                        text_font=sans-serif
                        paint_mode=brush
                        early_exit=false
                        fill_shape=false
                    '';
                };
            };
        })
    ];
}
