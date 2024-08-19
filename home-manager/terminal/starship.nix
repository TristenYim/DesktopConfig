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
                    ''
                    [░▒▓](#a3aed2)\\
                    $os\\
                    [](bg:#769ff0 fg:#a3aed2)\\
                    $directory\\
                    [](fg:#769ff0 bg:#394260)\\
                    $git_branch\\
                    $git_status\\
                    [](fg:#394260 bg:#212736)\\
                    $nodejs\\
                    $nix_shell\\
                    $rust\\
                    $golang\\
                    $php\\
                    [](fg:#212736 bg:#1d2230)\\
                    $time\\
                    [ ](fg:#1d2230)
                    $character
                    ''
                ];
                directory = {
                    style = "fg:#e3e5e5 bg:#769ff0";
                    format = "[ $path ]($style)";
                    truncation_length = 3;
                    truncation_symbol = "…/";
                    substitutions = {
                        "Documents" = "󰈙 ";
                        "Downloads" = " ";
                        "Music" = " ";
                        "Pictures" = " ";
                        "/etc/nixos" = "etc/  ";
                        "/nix/store" = "nix/ 󰀻 ";
                    };
                };
                git_branch = {
                    symbol = "";
                    style = "bg:#394260";
                    format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
                };
                git_status = {
                    style = "bg:#394260";
                    format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
                };
                nodejs = {
                    symbol = "";
                    style = "bg:#212736";
                    format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
                };
                nix_shell = {
                    style = "bg:#212736";
                    impure_msg = "[ impure 󰼩 ](fg:#f38ba8 bg:#212736)";
                    pure_msg = "[ pure!! 󱩰 ](fg:#a6e3a1 bg:#212736)";
                    unknown_msg = "[ ??? 󱓣 ](fg:#769ff0 bg:#212736)";
                    format = "[[$state \\($name\\) \\[nix-shell\\]](fg:#769ff0 bg:#212736)]($style)";
                };
                rust = {
                    symbol = "";
                    style = "bg:#212736";
                    format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
                };
                golang = {
                    symbol = "";
                    style = "bg:#212736";
                    format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
                };
                php = {
                    symbol = "";
                    style = "bg:#212736";
                    format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
                };
                time = {
                    disabled = false;
                    time_format = "%R"; # Hour:Minute Format
                    style = "bg:#1d2230";
                    format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
                };
                os = {
                    disabled = false;
                    format = "[  $symbol](bg:#a3aed2 fg:#090c0c)"; # Be proud that you're using nix!
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
