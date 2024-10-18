{ config, pkgs, lib, ... }: {

    # Set a toggle to enable Starship
    options = {
        starship-home.enable = lib.mkEnableOption "Enables Starship with Home Manager";
    };
 
    config = lib.mkIf config.starship-home.enable 
    {
        programs.starship = {
            enable = true;
            settings = {
                
                # Note: This is just a copy of Tokyo Night
                
                format = lib.concatStrings [
                    "[░▒▓](peach)"
                    "$os"
                    "[](fg:peach bg:yellow)"
                    "$directory"
                    "[](fg:yellow bg:lavender)"
                    "$git_branch"
                    "$git_status"
                    "[](fg:lavender bg:surface1)"
                    "$nix_shell"
                    "$nodejs"
                    "$rust"
                    "$golang"
                    "$php"
                    "$git_metrics"
                    "[](fg:surface1 bg:surface0)"
                    "$time"
                    "[\n](fg:surface0)"
                    "$character"
                ];
                directory = {
                    style = "fg:surface0 bg:yellow";
                    format = "[ $path ]($style)";
                    truncation_length = 3;
                    truncation_symbol = "…/";
                    substitutions = {
                        "Documents" = "󰈙 ";
                        "Downloads" = " ";
                        "Music" = " ";
                        "Pictures" = " ";
                        "home" = "󰚡 ";
                        "/media/Hdd" = "…/󱛟 ";
                        "/pers" = " ";
                        # "/etc/nixos" = "…/ ";
                        "/nix/store" = "…/ 󰀻 ";
                    };
                };
                git_branch = {
                    symbol = "";
                    style = "fg:surface1 bg:lavender";
                    format = "[ $symbol $branch ]($style)";
                };
                git_status = {
                    style = "fg:surface1 bg:lavender";
                    format = "[($all_status$ahead_behind )]($style)";
                };
                git_metrics = {
                    disabled = false;
                    added_style = "fg:green bg:surface1";
                    deleted_style = "fg:red bg:surface1";
                    only_nonzero_diffs = false;
                    format = "[ \\(](fg:text bg:surface1)([+$added]($added_style))[/](fg:text bg:surface1)([-$deleted]($deleted_style)[\\) ](fg:text bg:surface1))";
                };
                nodejs = {
                    symbol = "";
                    style = "fg:text bg:surface1";
                    format = "[ $symbol ($version) ]($style)";
                };
                nix_shell = {
                    style = "fg:mauve bg:surface1";
                    impure_msg = "[ impure 󰼩 ](fg:red bg:surface1)";
                    pure_msg = "[ pure!! 󱩰 ](fg:green bg:surface1)";
                    unknown_msg = "[ ??? 󱓣 ](fg:mauve bg:surface1)";
                    format = "[$state \\[nix-shell: $name\\]]($style)";
                };
                rust = {
                    symbol = "";
                    style = "fg:text bg:surface1";
                    format = "[ $symbol ($version) ]($style)";
                };
                golang = {
                    symbol = "";
                    style = "fg:text bg:surface1";
                    format = "[ $symbol ($version) ]($style)";
                };
                php = {
                    symbol = "";
                    style = "fg:text bg:surface1";
                    format = "[ $symbol ($version) ]($style)";
                };
                time = {
                    disabled = false;
                    time_format = "%R"; # Hour:Minute Format
                    style = "fg:text bg:surface0";
                    format = "[  $time ]($style)";
                };
                os = {
                    disabled = false;
                    format = "[  $symbol](fg:base bg:peach)"; # Be proud that you're using nix!
                    symbols = {
                        Alpaquita = " ";
                        Alpine = " ";
                        AlmaLinux = " ";
                        Amazon = " ";
                        Android = " ";
                        Arch = " ";
                        Artix = " ";
                        CentOS = " ";
                        Debian = " ";
                        DragonFly = " ";
                        Emscripten = " ";
                        EndeavourOS = " ";
                        Fedora = " ";
                        FreeBSD = " ";
                        Garuda = "󰛓 ";
                        Gentoo = " ";
                        HardenedBSD = "󰞌 ";
                        Illumos = "󰈸 ";
                        Kali = " ";
                        Linux = " ";
                        Mabox = " ";
                        Macos = " ";
                        Manjaro = " ";
                        Mariner = " ";
                        MidnightBSD = " ";
                        Mint = " ";
                        NetBSD = " ";
                        NixOS = "";
                        OpenBSD = "󰈺 ";
                        openSUSE = " ";
                        OracleLinux = "󰌷 ";
                        Pop = " ";
                        Raspbian = " ";
                        Redhat = " ";
                        RedHatEnterprise = " ";
                        RockyLinux = " ";
                        Redox = "󰀘 ";
                        Solus = "󰠳 ";
                        SUSE = " ";
                        Ubuntu = " ";
                        Unknown = " ";
                        Void = " ";
                        Windows = "󰍲 ";
                    };
                };
            };
        };
    };
}
