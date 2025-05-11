{ config, lib, ... }: {

    # Set a toggle to enable zsh config
    options.apeiron = {
        zsh.enable = lib.mkEnableOption "zsh configuration";
    };
 
    config = lib.mkIf config.apeiron.zsh.enable 
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
                initContent = ''
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
