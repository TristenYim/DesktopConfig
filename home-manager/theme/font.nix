{ config, pkgs, lib, ... }: 
let
    cfg = config.apeiron.desktop.theme.fonts;
in
{
    options.apeiron.desktop.theme.fonts = {
        enable = lib.mkEnableOption "font installation";
        merienda.enable = lib.mkEnableOption "the merienda font";
    };
 
    config = lib.mkMerge [
        # Unintuitively, just installing the font package does not make it usable.
        # Fontconfig must be enabled to make installed fonts usable.
        (lib.mkIf cfg.enable { 
            fonts.fontconfig.enable = true;
        })
        (lib.mkIf (cfg.enable && cfg.merienda.enable) { 
            home.packages = [ pkgs.merienda ];
        })
    ];
}
