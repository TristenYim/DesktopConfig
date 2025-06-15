# Manages Hyprland plugins
# Note that since this is done using Home Manager, there is no need to use hyprpm

{ config, pkgs, lib, hyprspace, hyprsplit, ... }: 
let
    cfg = config.apeiron.desktop.hyprland.plugins;

    helpers = import ./helpers.nix { inherit lib; };
    windowBinds = import ./keybinds/window-binds.nix { inherit helpers; };
    workspaceBinds = import ./keybinds/workspace-binds.nix { inherit helpers; };
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
                    hyprspace.packages.${pkgs.system}.Hyprspace
                ];

                settings = {
                    bind = helpers.bindWithManyDispatchers ", ALT_L" [ "overview:open, all" "submap, altl" ];
                    
                    plugin.overview = {
                        autoScroll = false;
                        exitOnClick = false;
                        switchOnDrop = true;
                        showNewWorkspace = false;
                        showEmptyWorkspace = false;
                    };
                };

                extraConfig = (helpers.makeSubmap
                    "altl"
                    (
                        # Exit overview
                        helpers.bindsWithSameDispatcher [ ", ESCAPE" ", ALT_L" ", ENTER" ", SUPER_L" ] "overview:close, all"
                        ++ helpers.bindsWithSameDispatcher [ ", ESCAPE" ", ALT_L" ", ENTER" ", SUPER_L" ] "submap, reset"

                        ++ windowBinds.allBinds
                        ++ workspaceBinds.jumpTo
                        ++ workspaceBinds.moveWindowTo
                        ++ workspaceBinds.switchMonitor
                        ++ workspaceBinds.swapMonitorWorkspaces
                        ++ workspaceBinds.forAll
                        ++ workspaceBinds.scroll
                    )
                    []
                );
            };
        })

        ( lib.mkIf cfg.hyprsplit.enable {
            wayland.windowManager.hyprland.plugins = [
                hyprsplit.packages.${pkgs.system}.hyprsplit
            ];
        })
    ];
}
