{ config, pkgs, lib, ... }: 
let
    myLib = import ../resources/myLib.nix { inherit config pkgs lib; };
in
{
    options = {
        btop.enable = lib.mkEnableOption "BTOP++";
        cryptsetup.enable = lib.mkEnableOption "cryptsetup";
        envfs.enable = lib.mkEnableOption "envfs";
        fd.enable = lib.mkEnableOption "fd";
        flatpak.enable = lib.mkEnableOption "flatpak";
        killall.enable = lib.mkEnableOption "killall";
        nixos-cli.enable = lib.mkEnableOption "nixos-cli";
        openrgb.enable = lib.mkEnableOption "openrgb";
        pulse.enable = lib.mkEnableOption "PulseAudio";
        pipewire.enable = lib.mkEnableOption "PipeWire";
        ranger.enable = lib.mkEnableOption "ranger";
        sddm.enable = lib.mkEnableOption "SDDM";
        syncthing.enable = lib.mkEnableOption "syncthing";
        vim.enable = lib.mkEnableOption "vim";
    };

    # Allows us to combine multiple modules into one file
    config = lib.mkMerge
    [
        {
            environment = {
                pathsToLink = [
                    "/share/zsh"
                ];

                systemPackages = [
                    pkgs.unchartedScripts
                ];
            };
        }

        # Btop++, added to ensure a system monitor exists without Home Manager
        ( myLib.nixos.enablePkgSameOptName "btop" )

        # Cryptsetup, used to create dm-crypt/LUKS devices
        ( myLib.nixos.enablePkgSameOptName "cryptsetup" )

        # Envfs, restores some FHS compliance
        ( lib.mkIf config.envfs.enable {
            services.envfs.enable = true;
        })

        # fd, faster alternative to find
        ( myLib.nixos.enablePkgSameOptName "fd" )

        # Flatpak, alternative package installer
        ( lib.mkIf config.flatpak.enable {
            services.flatpak.enable = true;
            xdg.portal = {            
                enable = true;
                extraPortals = [ 
                    pkgs.xdg-desktop-portal-gtk 
                    pkgs.kdePackages.xdg-desktop-portal-kde 
                ];
                config.common.default = "gtk";
            };
        })

        ( myLib.nixos.persistIf "flatpak" [ "/var/lib/flatpak" ] [ ] )

        # Killall, which does what you'd expect
        ( myLib.nixos.enablePkgSameOptName "killall" )

        # nixos-cli, adds a better cli for NixOS operations
        ( lib.mkIf config.nixos-cli.enable {
            services.nixos-cli = {
                enable = true;
            };
        })

        # openrgb, allows controlling connected RGB devices
        ( lib.mkIf config.openrgb.enable {
            services.hardware.openrgb.enable = true;
        })

        # Pulseaudio, sound server
        ( lib.mkIf config.pulse.enable {
            hardware.pulseaudio = {
                enable = true;
                package = pkgs.pulseaudioFull;
                support32Bit = true;
            };
            nixpkgs.config.pulseaudio = true;

            environment.systemPackages = [
                pkgs.pavucontrol
                pkgs.pamixer
            ];
        })

        # PipeWire, the better sound server and more
        ( lib.mkIf config.pipewire.enable {
            services.pipewire = {
                enable = true;
                pulse.enable = true;
                alsa = {
                    enable = true;
                    support32Bit = true;
                };
            };

            environment.systemPackages = [
                pkgs.pavucontrol
                pkgs.pamixer
            ];
        })

        # Ranger, added to ensure a decent TUI file manager exists without Home Manager
        ( myLib.nixos.enablePkgSameOptName "ranger" )

        # SDDM, display (login) manager
        ( lib.mkIf config.sddm.enable {
            services = {
                displayManager.sddm = {
                     enable = true;
                     wayland.enable = true;
                };
            };
        })

        # Syncthing, self-hosted file synchronization platform
        ( lib.mkIf config.syncthing.enable {
            services.syncthing = {
                enable = true;
            };
        })

        ( myLib.nixos.persistIf "syncthing" [ { directory = "/var/lib/syncthing"; user = "syncthing"; group = "syncthing"; mode = "700"; } ] [ ] )

        # vim, added to ensure a decent text editor exists even without Home Manager
        ( myLib.nixos.enablePkgSameOptName "vim" )
    ];
}
