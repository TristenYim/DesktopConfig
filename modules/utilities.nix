{ config, pkgs, lib, myLib, ... }: 

{
    imports = with pkgs; [
        ( myLib.nixos.mkPkgModule btop [ "btop" ] ) # Btop++, added to ensure a system monitor exists without Home Manager
        ( myLib.nixos.mkPkgModule cryptsetup [ "cryptsetup" ] ) # Cryptsetup, used to create dm-crypt/LUKS devices
        ( myLib.nixos.mkPkgModule fd [ "fd" ] ) # fd, faster alternative to find
        ( myLib.nixos.mkPkgModule killall [ "killall" ] ) # Killall, does what you'd expect
        ( myLib.nixos.mkPkgModule ranger [ "ranger" ] ) # Ranger, added to ensure a TUI file manager exists even without Home Manager
        ( myLib.nixos.mkPkgModule vim [ "vim" ] ) # vim, added to ensure a decent text editor exists even without Home Manager

        ( myLib.nixos.mkPersistenceModule [ "/var/lib/flatpak" ] [ ] [ "flatpak" ] )
        ( myLib.nixos.mkPersistenceModule [ { directory = "/var/lib/syncthing"; user = "syncthing"; group = "syncthing"; mode = "700"; } ] [ ] [ "syncthing" ] )
    ];

    options.apeiron = {
        envfs.enable = lib.mkEnableOption "envfs";
        flatpak.enable = lib.mkEnableOption "flatpak";
        nixos-cli.enable = lib.mkEnableOption "nixos-cli";
        openrgb.enable = lib.mkEnableOption "openrgb";
        pulse.enable = lib.mkEnableOption "PulseAudio";
        pipewire.enable = lib.mkEnableOption "PipeWire";
        sddm.enable = lib.mkEnableOption "SDDM";
        syncthing.enable = lib.mkEnableOption "syncthing";
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

        # Envfs, restores some FHS compliance
        ( lib.mkIf config.apeiron.envfs.enable {
            services.envfs.enable = true;
        })

        # Flatpak, alternative package installer
        ( lib.mkIf config.apeiron.flatpak.enable {
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

        # nixos-cli, adds a better cli for NixOS operations
        ( lib.mkIf config.apeiron.nixos-cli.enable {
            services.nixos-cli = {
                enable = true;
            };
        })

        # openrgb, allows controlling connected RGB devices
        ( lib.mkIf config.apeiron.openrgb.enable {
            services.hardware.openrgb.enable = true;
        })

        # Pulseaudio, sound server
        ( lib.mkIf config.apeiron.pulse.enable {
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
        ( lib.mkIf config.apeiron.pipewire.enable {
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

        # SDDM, display (login) manager
        ( lib.mkIf config.apeiron.sddm.enable {
            services = {
                displayManager.sddm = {
                     enable = true;
                     wayland.enable = true;
                };
            };
        })

        # Syncthing, self-hosted file synchronization platform
        ( lib.mkIf config.apeiron.syncthing.enable {
            services.syncthing = {
                enable = true;
            };
        })
    ];
}
