# NVIDIA hardware configuration
# See https://nixos.wiki/wiki/Nvidia for more

{ config, lib, ... }: {
    options = {
        nvidia.enable = lib.mkEnableOption "Enables proprietary NVIDIA driver settings";
    };

    config = ( lib.mkIf config.nvidia.enable {
        # Manually sets tty resolution
        # Required for switching to tty with the NVIDIA framebuffer
        # when the resolution of multiple monitors differ, for some
        # unknown reason.

        # Note: For this problem, referencing pages such
        # https://nixos.wiki/wiki/Nvidia#Booting_to_Text_Mode
        # did not help at all.
        boot = {
            kernelParams = [ "video=1920x1080" ];
        };

        # Load NVIDIA driver for Xorg and Wayland
        services.xserver = {
            videoDrivers = [ "nvidia" ];
        };

        hardware = {
            # Enable OpenGL
            graphics = {
                enable = true;
                enable32Bit = true;
            };

            nvidia = {
                # Modesetting is required for Wayland
                modesetting.enable = true;

                # NVIDIA power management. Experimental, and can cause sleep/suspend to fail.
                # Enable this if you have graphical corruption issues or application crashes after waking
                # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
                # of just the bare essentials.
                powerManagement.enable = false;

                # Fine-grained power management. Turns off GPU when not in use.
                # Experimental and only works on modern NVIDIA GPUs (Turing or newer).
                powerManagement.finegrained = false;

                # Use the NVIDIA open source kernel module (not to be confused with the
                # independent third-party "nouveau" open source driver).
                # Support is limited to Turing and later architectures. Full list of
                # supported GPUs is at:
                # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
                # Only available from driver 513.43.04+
                # Currently alpha-quality/buggy, so false is currently the recommended setting.
                open = false;

                # Enable the NVIDIA settings menu
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
