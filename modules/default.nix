# This imports all other NixOS modules and defines groups of default modules to enable.

# Note that additional default settings are defined in system.nix. I did it this way
# because it didn't make sense to wrap the default system options behind a custom option
# - There's no reason to disable the bare minimum to create a functional OS.

{ config, lib, ... }: {

    imports = [
        ./desktop-environment.nix
        ./nvidia.nix
        ./system.nix
        ./users.nix
        ./utilities.nix
        ./persistence.nix
        ./virtualisation/virtualisation.nix
        ../overlays/default.nix
    ];

    options.apeiron = {
        hyprDE.enable = lib.mkEnableOption "a custom \"desktop environment\" based on Hyprland";
    };

    config = lib.mkMerge [
        {
            apeiron = {
                btop.enable = lib.mkDefault true;
                catppuccin-local.enable = lib.mkDefault true;
                greetd.enable = lib.mkDefault true;
                fd.enable = lib.mkDefault true;
                flatpak.enable = lib.mkDefault true;
                fwupd.enable = lib.mkDefault true;
                killall.enable = lib.mkDefault true;
                nerdfonts.enable = lib.mkDefault true;
                pipewire.enable = lib.mkDefault true;
                ranger.enable = lib.mkDefault true;
                vim.enable = lib.mkDefault true;

                users.fathom.enable = lib.mkDefault true;
            };
        }

        # HyprDE
        ( lib.mkIf config.apeiron.hyprDE.enable {
            apeiron = {
                kitty.enable = lib.mkDefault true;
                hyprland.enable = lib.mkDefault true;
                swaylock.enable = lib.mkDefault true;
                thunar.enable = lib.mkDefault true;
            };
        })
    ];
}
