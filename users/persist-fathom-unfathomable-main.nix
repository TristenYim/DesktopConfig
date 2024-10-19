# Declares persistent files and directories in /home
# These are NOT erased on reboot in the impermanence setup
{ config, pkgs, lib, ... }: {
    home.persistence."/pers/home/fathom" = {
        directories = [

            # The Freedesktop directories, except for useless ones like "Desktop"
            "Documents"
            "Music"
            "Pictures"
            "Videos"

            ".ssh" # Stores a lot of information, including github keys and trusted host
            ".local/share/nvim/site/spell" # Nvim spell-check files
            ".local/share/fonts" # Local fonts
            ".local/share/bottles" # Use Bottles! for Affinity Photo
            ".mozilla/firefox/user" # Firefox user profile
            ".thunderbird/user" # Thunderbird user profile
            ".config/Cider/Themes" # Cider themes
            ".config/Slack" # Slack data
            ".config/sh.cider.classic" # Cider data
            ".config/PrusaSlicer" # Prusa Slicer data
        ];
        files = [
            ".command_history"
        ];
        allowOther = true;
    };
}
