{ config, pkgs, lib, ... }: {

    # Define the rasi themes in a separate file
    imports = [ 
        ./run.nix 
    ];

    options.apeiron.desktop.utilities = {
        rofi.enable = lib.mkEnableOption "Rofi";
    };
 
    config = lib.mkIf config.apeiron.desktop.utilities.rofi.enable 
    {
        programs.rofi = {
            enable = true;
	        terminal = "kitty";
            package = pkgs.rofi-wayland;
        };
    };
}
