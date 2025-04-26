{ config, pkgs, lib, ... }: {

    # Define the rasi themes in a separate file
    imports = [ 
        ./run.nix 
    ];

    options.apeiron = {
        rofi.enable = lib.mkEnableOption "Rofi";
    };
 
    config = lib.mkIf config.apeiron.rofi.enable 
    {
        programs.rofi = {
            enable = true;
	        terminal = "kitty";
            package = pkgs.rofi-wayland;
        };
    };
}
