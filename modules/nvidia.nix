# NVidia hardware configuration
# See https://nixos.wiki/wiki/Nvidia for more

{ config, lib, ... }: {
    options = {
        nvidia.enable = lib.mkEnableOption "Enables proprietary NVidia driver settings";
    };

    config = ( lib.mkIf config.nvidia.enable {
        # Load NVidia driver for Xorg and Wayland
        services.xserver.videoDrivers = [ "nvidia" ];

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

                # Ensures the GPU is always awake, even when running without a GUI
                # Enabling this to potentially fix boot errors
                nvidiaPersistenced = true;

                # Select the driver version
                package = config.boot.kernelPackages.nvidiaPackages.beta;
            };
        };
    });
}
