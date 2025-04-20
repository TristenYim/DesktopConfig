{ config, pkgs, lib, hyprland, ... }: 
let
    myLib = import ../resources/myLib.nix { inherit config pkgs lib; };
in
{
    options = {
        xfce.enable = lib.mkEnableOption "Xfce";
        catppuccin-local.enable = lib.mkEnableOption "Catppuccin";
        kitty.enable = lib.mkEnableOption "kitty";
        hyprland.enable = lib.mkEnableOption "Hyprland";
        nerdfonts.enable = lib.mkEnableOption "Nerd Fonts";
        swaylock.enable = lib.mkEnableOption "Swaylock";
        thunar.enable = lib.mkEnableOption "Thunar";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        ( myLib.nixos.enableEachPkgWith [
            [ "kitty" "kitty" ] # This is only enabled to have a terminal by default - It doesn't require root permissions
            [ "swaylock-effects" "swaylock" ] # Screen locker
        ])

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

                # Disable unwanted catppuccin configurations
                sddm.enable = false;
            };
        })

        # Hyprland
        ( lib.mkIf config.hyprland.enable {
            programs.hyprland = {
                enable = true;
                package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
                portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
                # package = pkgs.hyprland;
            };
        })

        # Nerd Fonts
        ( lib.mkIf config.nerdfonts.enable {
            fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
        })

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
