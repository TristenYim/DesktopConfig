# Manages Hyprland plugins
# Note that since this is done using Home Manager, there is no need to use hyprpm

{ config, pkgs, lib, ... }: 
let
    cfg = config.apeiron.desktop.hyprland.plugins;
in
{
    options.apeiron.desktop.hyprland.plugins = {
        hyprspace.enable = lib.mkEnableOption "the hyprspace plugin";
        hyprsplit.enable = lib.mkEnableOption "the hyprsplit plugin";
    };

    config = lib.mkMerge
    [
        ( lib.mkIf cfg.hyprspace.enable {
            wayland.windowManager.hyprland = {
                plugins = [
                    pkgs.hyprlandPlugins.hyprspace
                ];

                settings = {
                    # bind = helpers.bindWithManyDispatchers ", ALT_L" [ "overview:open, all" "exec, hyprctl keyword general:gaps_out 10,170,190,170" "submap, altl" ];
                    
                    plugin.overview = {
                        affectStrut = false;
                        autoScroll = false;
                        exitOnClick = false;
                        exitKey = 0;
                        hideRealLayers = false;
                        onBottom = true;
                        panelHeight = 180;
                        switchOnDrop = true;
                        showNewWorkspace = false;
                        showEmptyWorkspace = false;
                    };
                };

                # TODO Reimplement overview submap

                # extraConfig = (helpers.makeSubmap
                #     "altl"
                #     (
                #         # Exit overview
                #         helpers.bindsWithSameDispatcher [ ", ESCAPE" ", ALT_L" ", ENTER" ", SUPER_L" ] "overview:close, all"
                #         ++ helpers.bindsWithSameDispatcher [ ", ESCAPE" ", ALT_L" ", ENTER" ", SUPER_L" ] "exec, hyprctl keyword general:gaps_out ${builtins.toString config.wayland.windowManager.hyprland.settings.general.gaps_out}"
                #         ++ helpers.bindsWithSameDispatcher [ ", ESCAPE" ", ALT_L" ", ENTER" ", SUPER_L" ] "submap, reset"
                #
                #         ++ windowBinds.allBinds
                #         ++ workspaceBinds.jumpTo
                #         ++ workspaceBinds.moveWindowTo
                #         ++ workspaceBinds.switchMonitor
                #         ++ workspaceBinds.swapMonitorWorkspaces
                #         ++ workspaceBinds.forAll
                #         ++ workspaceBinds.scroll
                #     )
                #     []
                # );
            };
        })

        ( lib.mkIf cfg.hyprsplit.enable {
            wayland.windowManager.hyprland.plugins = [
                pkgs.hyprlandPlugins.hyprsplit
            ];
        })
    ];
}
