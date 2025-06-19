{ config, pkgs, lib, ... }: 
let
    cfg = config.programs.nix-search-tv;
    jsonFormat = pkgs.formats.json { };
in
{
    options.programs.nix-search-tv = {
        enable = lib.mkEnableOption "nix-search-tv, a nix package and option index";
        package = lib.mkPackageOption pkgs "nix-search-tv" { nullable = true; };
        televisionIntegration = lib.mkEnableOption "television integration with nix-search-tv";
        settings = lib.mkOption {
            type = jsonFormat.type;
            default = { };
            example = lib.literalExpression ''
                # TODO Add example
            '';
            description = ''
                # TODO Add description
            '';
        };
    };
 
    config = lib.mkIf cfg.enable { 
        home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];

        xdg.configFile."nix-search-tv/config.json" = lib.mkIf (cfg.settings != { }) {
            source = jsonFormat.generate "config.json" cfg.settings;
        };

        programs.television.channels = lib.mkIf cfg.televisionIntegration {
            nix-search-tv.cable_channel = [
                {
                    name = "pkgs";
                    source_command = "${cfg.package}/bin/nix-search-tv print";
                    preview_command = "${cfg.package}/bin/nix-search-tv preview {}";
                }
            ];
        };
    };
}
