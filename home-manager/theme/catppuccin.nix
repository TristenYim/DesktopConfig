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

        # Enable catppuccin in GTK and Qt
        gtk.catppuccin.enable = true;
        qt = {
            style.catppuccin.enable = true;
            style.name = "kvantum";
            platformTheme.name = "kvantum";
        };

        # Having catppuccin enabled here causes build issues with my custom config
        programs.rofi.catppuccin.enable = false;
        programs.waybar.catppuccin.enable = false;
    };
}
