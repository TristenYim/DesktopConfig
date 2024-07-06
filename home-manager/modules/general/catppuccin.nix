{ config, pkgs, lib, ... }: {

    # Set a toggle to enable Catppuccin
    options = {
        catppuccin-home.enable = lib.mkEnableOption "Enables Catppuccin with Home Manager";
    };
 
    config = lib.mkIf config.catppuccin-home.enable 
    {
        catppuccin = {
            enable = true;
            flavor = "mocha";
            accent = "teal";
        };
        programs.rofi.catppuccin.enable = false;
        programs.waybar.catppuccin.enable = false;
    };
}
