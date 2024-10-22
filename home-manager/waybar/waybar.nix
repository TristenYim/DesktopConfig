{ config, lib, ... }: 
let
    makeBar = ( import ./makeBar.nix );
    styler = ( import ./styleMaker.nix );
in
{

    # Set a toggle to enable Waybar
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
            settings = lib.mkDefault [ (makeBar "default" "") ];
            style = lib.mkDefault (
                styler.makeGlobal +
                styler.makeUnique "default" 20 8 8 18 8
            );
        };
    };
}
