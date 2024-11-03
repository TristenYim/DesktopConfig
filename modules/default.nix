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
        ./virtualisation.nix
        # ../overlays/hyprland-overlay.nix
    ];

    options = {
        hyprDE.enable = lib.mkEnableOption "Enables a custom \"desktop environment\" based on Hyprland";
    };

    config = lib.mkMerge [
        {
            btop.enable = lib.mkDefault true;
            catppuccin.enable = lib.mkDefault true;
            envfs.enable = lib.mkDefault true;
            flatpak.enable = lib.mkDefault true;
            killall.enable = lib.mkDefault true;
            nerdfonts.enable = lib.mkDefault true;
            nixos-cli.enable = lib.mkDefault true;
            # pulse.enable = lib.mkDefault true;
            pipewire.enable = lib.mkDefault true;
            ranger.enable = lib.mkDefault true;
            sddm.enable = lib.mkDefault true;
            vim.enable = lib.mkDefault true;

            users-fathom.enable = lib.mkDefault true;
        }

        # HyprDE
        ( lib.mkIf config.hyprDE.enable {
            kitty.enable = lib.mkDefault true;
            hyprland.enable = lib.mkDefault true;
            swaylock.enable = lib.mkDefault true;
            thunar.enable = lib.mkDefault true;
        })
    ];
}
