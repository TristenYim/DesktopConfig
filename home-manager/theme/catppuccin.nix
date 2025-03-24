{ config, lib, ... }: {

    # Set a toggle to enable Catppuccin
    options = {
        catppuccin-home.enable = lib.mkEnableOption "Catppuccin";
    };
 
    config = lib.mkIf config.catppuccin-home.enable 
    {
        catppuccin = {
            enable = true;
            flavor = "mocha";
            accent = "sky";

            # Enable catppuccin in GTK and Kvantum
            gtk.enable = true;
            kvantum.enable = true;

            # Having catppuccin enabled here causes build issues with my custom config
            rofi.enable = false;
            waybar.enable = false;
            wlogout.enable = false;
        };

        # Enable Kvantum to use catppuccin
        qt = {
            style.name = "kvantum";
            platformTheme.name = "kvantum";
        };
    };
}
