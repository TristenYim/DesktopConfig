{ config, pkgs, lib, myLib, ... }: 

{
    imports = with pkgs; [
        ( myLib.nixos.mkPkgModule kitty [ "kitty" ] ) # This is only enabled to have a terminal by default - It doesn't require root permissions
        ( myLib.nixos.mkPkgModule swaylock-effects [ "swaylock" ] ) # Screen locker
    ];

    options.apeiron = {
        xfce.enable = lib.mkEnableOption "Xfce";
        catppuccin-local.enable = lib.mkEnableOption "Catppuccin";
        hyprland.enable = lib.mkEnableOption "Hyprland";
        nerdfonts.enable = lib.mkEnableOption "Nerd Fonts";
        thunar.enable = lib.mkEnableOption "Thunar";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        # Xfce
        ( lib.mkIf config.apeiron.xfce.enable {
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
            apeiron.thunar.enable = lib.mkDefault true;
        })

        # Catppuccin
        ( lib.mkIf config.apeiron.catppuccin-local.enable {
            catppuccin = {
                enable = true;
                accent = "sky";
                flavor = "mocha";

                # Disable unwanted catppuccin configurations
                sddm.enable = false;
            };
        })

        # Hyprland
        ( lib.mkIf config.apeiron.hyprland.enable {
            programs.hyprland = {
                enable = true;
                withUWSM = true;
            };
        })

        # Nerd Fonts
        ( lib.mkIf config.apeiron.nerdfonts.enable {
            fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
        })

        # Thunar
        ( lib.mkIf config.apeiron.thunar.enable {
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
