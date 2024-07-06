{ config, pkgs, lib, ... }: {
    options = {
        bottles.enable = lib.mkEnableOption "Use Bottles!";
        btop.enable = lib.mkEnableOption "Enables BTOP++";
        flatpak.enable = lib.mkEnableOption "Enables flatpak";
        grimSwappy.enable = lib.mkEnableOption "Enables grim + swappy screenshot tools";
        neofetch.enable = lib.mkEnableOption "Enables neofetch";
        pulse.enable = lib.mkEnableOption "Enables PulseAudio";
        ranger.enable = lib.mkEnableOption "Enables ranger";
        sddm.enable = lib.mkEnableOption "Enables SDDM";
        vim.enable = lib.mkEnableOption "Enables vim";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        {
            environment.etc."current-system-packages".text =
              let
                packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
                sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
                formatted = builtins.concatStringsSep "\n" sortedUnique;
              in
                formatted; 
            bottles.enable = lib.mkDefault true;
            btop.enable = lib.mkDefault true;
            flatpak.enable = lib.mkDefault true;
            grimSwappy.enable = lib.mkDefault true;
            neofetch.enable = lib.mkDefault true;
            pulse.enable = lib.mkDefault true;
            sddm.enable = lib.mkDefault true;
            vim.enable = lib.mkDefault true;

            # TODO: ADD THUNAR ARCHIVE MANAGER SINCE NIXOS ISN'T DOING IT
            environment.systemPackages = [
                pkgs.unzip
            ];
        }

        # Flatpak
        ( lib.mkIf config.flatpak.enable {
            services.flatpak.enable = true;
            xdg.portal = {            
                enable = true;
                extraPortals = [ 
                    pkgs.xdg-desktop-portal-gtk 
                ];
                config.common.default = "gtk";
            };
        })

        # Use Bottles!
        ( lib.mkIf config.btop.enable {
            environment.systemPackages = [
                pkgs.bottles
            ];
        })

        # Btop++
        ( lib.mkIf config.btop.enable {
            environment.systemPackages = [
                pkgs.btop
            ];
        })

        # Grim + Swappy screenshot utils
        ( lib.mkIf config.grimSwappy.enable {
            environment.systemPackages = [
                pkgs.grim
                pkgs.swappy
            ];
        })

        # Neofetch
        ( lib.mkIf config.neofetch.enable {
            environment.systemPackages = [
                pkgs.neofetch
            ];
        })

        # Pulseaudio
        ( lib.mkIf config.pulse.enable {
            hardware.pulseaudio.enable = true;
            environment.systemPackages = [
                pkgs.pavucontrol
                pkgs.pulseaudioFull
            ];
        })

        # Ranger
        ( lib.mkIf config.ranger.enable {
            environment.systemPackages = [
                pkgs.ranger
            ];
        })

        # SDDM
        ( lib.mkIf config.sddm.enable {
            environment.systemPackages = [
                pkgs.libsForQt5.sddm
            ];

            services = {
                displayManager.sddm = {
                     enable = true;
                     wayland.enable = true;
                     catppuccin.assertQt6Sddm = false;
                };
            };
        })

        # vim
        ( lib.mkIf config.vim.enable {
            environment.systemPackages = [
                pkgs.vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
            ];
        })
    ];
}
