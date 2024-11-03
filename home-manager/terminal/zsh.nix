{ config, pkgs, lib, ... }: {

    # Set a toggle to enable zsh config
    options = {
        zsh-home.enable = lib.mkEnableOption "Enables zsh configuration";
    };
 
    config = lib.mkIf config.zsh-home.enable 
    {
        programs = {
            zsh = {
                enable = true;
                autosuggestion = {
                    enable = true;
                    strategy = [ "completion" ];
                };
                dotDir = ".config/zsh";
                history = {
                    path = "$HOME/.command_history";
                    share = false;
                };
                sessionVariables = {
                    LOCALE_ARCHIVE = "$(nix-build '<nixpkgs>' -A glibcLocales)/lib/locale/locale-archive";
                    EDITOR = "nvim";
                };
                initExtra = ''
                    setopt INC_APPEND_HISTORY
                    bindkey "^[[1;5D" backward-word
                    bindkey "^[[1;5C" forward-word
                    bindkey "^H" backward-kill-word
                    bindkey "^[^?" backward-kill-word
                '';
            };
            kitty.settings.shell = "$HOME/.nix-profile/bin/zsh";
        };
    };
}
