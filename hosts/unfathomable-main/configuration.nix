# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./../../modules
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "unfathomable-main"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Los_Angeles";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    services.xserver = {

        # Configure keymap in X11
        xkb = {
            layout = "us";
            variant = "dvorak";
        };

        # Load NVidia driver for Xorg and Wayland
        videoDrivers = [ "nvidia" ];
    };

    # Configure console keymap
    console.keyMap = "dvorak";

    catppuccin-local.enable = true;
    darktable.enable = true;
    flatpak.enable = true;
    obs.enable = true;
    prusaSlicer.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # NVidia hardware configuration
    # See https://nixos.wiki/wiki/Nvidia
    hardware = {

        graphics = {
            enable = true;
        };

        nvidia = {

            # Modesetting is required
            modesetting.enable = true;

            # NVidia power management. Experimental, and can cause sleep/suspend to fail.
            # Enable this if you have graphical corruption issues or application crashes after waking
            # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
            # of just the bare essentials.
            powerManagement.enable = false;

            # Fine-grained power management. Turns off GPU when not in use.
            # Experimental and only works on modern NVidia GPUs (Turing or newer).
            powerManagement.finegrained = false;

            # Use the NVidia open source kernel module (not to be confused with the
            # independent third-party "nouveau" open source driver).
            # Support is limited to Turing and later architectures. Full list of
            # supported GPUs is at:
            # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
            # Only available from driver 513.43.04+
            # Currently alpha-quality/buggy, so false is currently the recommended setting.
            open = false;

            # Enable the NVidia settings menu
            # Accessible via 'nvidia-settings'.
            nvidiaSettings = true;

            # Select the driver version
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

}
