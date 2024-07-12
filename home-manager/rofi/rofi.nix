{ config, pkgs, lib, ... }: {

    # Set a toggle to enable Rofi
    options = {
        rofi-home.enable = lib.mkEnableOption "Enables Rofi with Home Manager";
    };
 
    config = lib.mkIf config.rofi-home.enable 
    {
        programs.rofi = {
            enable = true;
	        terminal = "kitty";
            package = pkgs.rofi-wayland;
        };

        home.file = {
            ".config/rofi/catppuccin.rasi" = {
                source = config.lib.file.mkOutOfStoreSymlink ./catppuccin.rasi;
            };
            ".config/rofi/run.rasi" = {
                source = config.lib.file.mkOutOfStoreSymlink ./run.rasi;
            };
        };
    };
}
