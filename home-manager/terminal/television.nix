{ config, lib, myLib, ... }: 
let
    cfg = config.apeiron.terminal.television;
in
{
    imports = [
        (myLib.home.mkPersistenceModule [ ".cache/nix-search-tv/nixpkgs" ] [ ] [ "terminal" "television" "nix-search-tv" ])
    ];

    options.apeiron.terminal = {
        television.enable = lib.mkEnableOption "television, fast and extensible fuzzy finder TUI";
        television.nix-search-tv.enable = lib.mkEnableOption "nix-search-tv, television integration for pkgs";
    };
 
    config = lib.mkMerge [
        (lib.mkIf cfg.enable { 
            programs.television = {
                enable = true;
                settings.ui.input_bar_position = "bottom";
            };
        }) 

        (lib.mkIf (cfg.enable && cfg.nix-search-tv.enable) {
            programs.nix-search-tv = {
                enable = true;
                televisionIntegration = true;
                settings = {
                    indexes = [ "nixpkgs" ];
                    update_interval = "6h";
                };
            };
        })
    ];
}
