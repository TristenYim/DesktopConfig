{ config, pkgs, lib, inputs, ... }: 
let
    myLib = import ../resources/myLib.nix { inherit config pkgs lib; };
in
{
    options = {
        xfce.enable = lib.mkEnableOption "Enables Xfce";
        catppuccin-local.enable = lib.mkEnableOption "Enables Catppuccin";
        kitty.enable = lib.mkEnableOption "Enables kitty";
        hyprland.enable = lib.mkEnableOption "Enables Hyprland";
        nerdfonts.enable = lib.mkEnableOption "Enables Nerd Fonts";
        swaylock.enable = lib.mkEnableOption "Enables Swaylock";
        thunar.enable = lib.mkEnableOption "Enables Thunar";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        # I want things to look nice by default
        {
            catppuccin.enable = lib.mkDefault true;
            nerdfonts.enable = lib.mkDefault true;
        }

        # HyprDE
        ( lib.mkIf config.hyprDE.enable {
            kitty.enable = lib.mkDefault true;
            hyprland.enable = lib.mkDefault true;
            swaylock.enable = lib.mkDefault true;
            thunar.enable = lib.mkDefault true;
        })

        # Xfce
        ( lib.mkIf config.xfce.enable {
            services.xserver = {
                enable = true;
                desktopManager = {
                    xterm.enable = false;
                    xfce = {
                        enable = true;
                        enableScreensaver = false;
                    };
                };
            };
            environment.xfce.excludePackages = [
                pkgs.xfce.parole 
                pkgs.xfce.ristretto 
                pkgs.xterm
            ];
            thunar.enable = lib.mkDefault true;
        })

        # Catppuccin
        ( lib.mkIf config.catppuccin-local.enable {
            catppuccin = {
                enable = true;
                accent = "sky";
                flavor = "mocha";
            };
        })

        # kitty
        # Note that this is only enabled to have a terminal enabled by default - It doesn't
        # need to be enabled system-wide to work.
        ( myLib.nixos.enablePkgSameOptName "kitty" )

        # Hyprland
        ( lib.mkIf config.hyprland.enable {
            programs.hyprland = {
                enable = true;
                package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
                portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
                # package = pkgs.hyprland;
            };
        })

        # Nerd Fonts
        ( lib.mkIf config.nerdfonts.enable {
            fonts.packages = [
                pkgs.nerdfonts
            ];
        })

        # Swaylock
        ( myLib.nixos.enablePkgWith "swaylock-effects" "swaylock" )

        # Thunar
        ( lib.mkIf config.thunar.enable {
            programs.thunar = {
                enable = true;

                # Note: Using these requires a separate polkit authentication
                # agent and archive manager. I've left that to be configured
                # in userspace.
                plugins = with pkgs.xfce; [
                    thunar-archive-plugin
                    thunar-volman
                ];
            };
            services = {
                gvfs.enable = true; # Enables mounting and trashing
                tumbler.enable = true; # Enables thumbnails
            };
        })
    ];
}
