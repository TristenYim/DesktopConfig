{ config, lib, ... }: {

    # Set a toggle to enable bash config
    # This is required to make some packages, such as rofi, work outside NixOS
    options.apeiron = {
        bash.enable = lib.mkEnableOption "bash configuration";
    };
 
    config = lib.mkIf config.apeiron.bash.enable 
    {
        programs.bash = {
            enable = true;
            sessionVariables = {
                LOCALE_ARCHIVE = "$(nix-build '<nixpkgs>' -A glibcLocales)/lib/locale/locale-archive";
                EDITOR = "nvim";
            };
            historyFile = "$HOME/.command_history";
        };
    };
}
