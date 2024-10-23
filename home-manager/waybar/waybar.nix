{ config, lib, ... }: 
let
    # These helper functions allow me to easily generate multiple bars with similar configurations.
    # The main purpose for this is to allow me to generate multiple bars with slightly different sizes, so they visually appear the same across each of my monitors.
    # Eventually, I may want to consider making my bars modular, since Nix would easily allow that.
    makeBar = ( import ./makeBar.nix );
    styler = ( import ./styleMaker.nix );
in
{
    options = {
        waybar-home.enable = lib.mkEnableOption "Enables Waybar with Home Manager";
    };
 
    config = lib.mkIf config.waybar-home.enable 
    {
        home = { 
            file = {
                ".config/waybar/scripts" = {
                    source = config.lib.file.mkOutOfStoreSymlink ./scripts;
                    recursive = true;
                };
            };
        };

        programs.waybar = {
            enable = true;
            systemd.enable = true;

            # These are arbitrary defaults. See ./makeBar and ./styleMaker
            settings = lib.mkDefault [ (makeBar "default" "") ];
            style = lib.mkDefault (
                styler.makeGlobal +
                styler.makeUnique "default" 20 8 8 18 8
            );
        };
    };
}
