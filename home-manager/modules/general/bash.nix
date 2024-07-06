{ config, pkgs, lib, ... }: {

    # Set a toggle to enable bash config
    # This is required to make some packages, such as rofi, work outside NixOS
    options = {
        bash-home.enable = lib.mkEnableOption "Enables bash configuration";
    };
 
    config = lib.mkIf config.bash-home.enable 
    {
        programs.bash = {
            enable = true;
            sessionVariables = {
                LOCALE_ARCHIVE = "$(nix-build '<nixpkgs>' -A glibcLocales)/lib/locale/locale-archive";
                EDITOR = "vim";
            };
        };
    };
}
