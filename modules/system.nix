# Based on the default configuration upon a fresh install

{ config, pkgs, lib, ... }: {

    # Bootloader
    boot.loader.systemd-boot.enable = lib.mkDefault true;
    boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

    # Use the latest kernel
    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    # networking.wireless.enable = lib.mkDefault true;  # Enables wireless support via wpa_supplicant

    # Configure network proxy if necessary
    # networking.proxy.default = lib.mkDefault "http://user:password@proxy:port/";
    # networking.proxy.noProxy = lib.mkDefault "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = lib.mkDefault true;

    # Set your time zone
    time.timeZone = lib.mkDefault "America/Los_Angeles";

    # Select internationalisation properties
    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = lib.mkDefault "en_US.UTF-8";
        LC_IDENTIFICATION = lib.mkDefault "en_US.UTF-8";
        LC_MEASUREMENT = lib.mkDefault "en_US.UTF-8";
        LC_MONETARY = lib.mkDefault "en_US.UTF-8";
        LC_NAME = lib.mkDefault "en_US.UTF-8";
        LC_NUMERIC = lib.mkDefault "en_US.UTF-8";
        LC_PAPER = lib.mkDefault "en_US.UTF-8";
        LC_TELEPHONE = lib.mkDefault "en_US.UTF-8";
        LC_TIME = lib.mkDefault "en_US.UTF-8";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = lib.mkDefault "us";
        variant = lib.mkDefault "dvorak";
    };

    # Configure console keymap
    console.keyMap = lib.mkDefault "dvorak";

    # Enable flakes and the nix command
    nix.settings.experimental-features = lib.mkDefault [ "nix-command" "flakes" ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = lib.mkDefault true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = lib.mkDefault true;
    # programs.gnupg.agent = {
    #   enable = lib.mkDefault true;
    #   enableSSHSupport = lib.mkDefault true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon
    # services.openssh.enable = lib.mkDefault true;

    # Open ports in the firewall
    # networking.firewall.allowedTCPPorts = lib.mkDefault [ ... ];
    # networking.firewall.allowedUDPPorts = lib.mkDefault [ ... ];
    # Or disable the firewall altogether
    # networking.firewall.enable = lib.mkDefault false;
}
