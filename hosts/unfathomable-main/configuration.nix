# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
    [
        ./hardware-configuration.nix # Include the results of the hardware scan
        ./filesystem.nix
        ./persist.nix
        ./../../modules
        ./../../users/PASSWORDHASH-fathom.nix # This is for keeping the password file outside of git history
    ];

    networking.hostName = "unfathomable-main"; # Define your hostname

    powerManagement.cpuFreqGovernor = "performance"; # We want maximum performance on a desktop

    # Use the latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Define a user account. Don't forget to set a password with ‘passwd’
    # somebody-user.enable = true;

    # Disable default password and source local hashed password
    users.users.fathom.initialPassword = null;

    # Enable custom modules
    flatpak.enable = true;
    hyprDE.enable = true;
    nvidia.enable = true;
    virtualisation.enable = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
}
