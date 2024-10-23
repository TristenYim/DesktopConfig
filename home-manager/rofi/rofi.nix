{ config, pkgs, lib, ... }: {

    # Define the rasi themes in a separate file
    imports = [ 
        ./run.nix 
    ];

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
    };
}
